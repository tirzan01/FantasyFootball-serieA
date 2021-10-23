# frozen_string_literal: true

class FantasyFootball

  def initialize
    @prompt = TTY::Prompt.new
  end

  def choose_team
    puts 'Please select one from the following team'
    Team.choices.each { |t| puts t }
    puts 'h - print help'
    input = @prompt.ask('Select corrisponding number:')

    exit if input == 'e'

    if input == 'h'
      help
      choose_team
    elsif input.to_i <= Team.choices.size && input.to_i > 0
      choose_player(Team.all[input.to_i - 1])
    else
      puts 'invalid Input'
      choose_team
    end

  end

  def choose_player(team)
    puts 'Please select one from the following players'
    players = Player.choices(team)
    players.each { |player| puts player[0] }
    puts 'h - print help'
    input = @prompt.ask('Select corrisponding number:')

    exit if input == 'e'

    if input == 'h'
      help
      choose_player(team)
    elsif input.to_i <= players.size && input.to_i > 0
      choose_action(players[input.to_i - 1][1])
    elsif input == 'b'
      choose_team
    else
      puts "ensure input is between [1, #{player.size}]"
      choose_player(team)
    end
  end

  def choose_action(player)
    phrase = 'choose one from the following action'
    choices = [
      { key: "d", name: "description", value: player.description },
      { key: "s", name: "statistics", value: player.stats },
      { key: "i", name: "info", value: player.info },
      { key: "b", name: "back to players selection", value: 'b' },
      { key: "e", name: "exit", value: 'e' }
    ]
    input = @prompt.expand(phrase, choices)

    exit if input == 'e'

    choose_player(player.team) if input == 'b'
    puts input
    choose_action(player)
  end

  private

  def help
    puts "I will help"
  end

end
