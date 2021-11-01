class FantasyFootballSerieA::CLI

  def initialize
    @prompt = TTY::Prompt.new
  end

  def call
    puts 'Hi, welcome to Fantasy Football Serie A league,'
    start
  end

  private

  def start
    phrase = 'press enter to start the application or press "h" for help'
    choices = [
      { key: "s", name: "start", value: 's' },
      { key: "g", name: "game description", value: 'g' },
      { key: "u", name: "update all players", value: 'u' },
      { key: "a", name: "application description", value: 'a' },
      { key: "e", name: "exit", value: 'e' }
    ]
    input = @prompt.expand(phrase, choices)

    case input
    when 's'
      display_teams
    when 'g'
      game_description
      start
    when 'u'
      update_all_warning
      FantasyFootballSerieA::Scraper.new.update_all if @prompt.yes?("do you want to update the database?")
      start
    when 'a'
      app_description
      start
    when 'e'
      exit
    end
  end

  def display_teams
    puts 'Please select one from the following team or press "h" for help'
    teams = FantasyFootballSerieA::Team.choices
    teams.each { |team| puts team[0] }
    choose_team(teams)
  end

  def choose_team(teams)
    input = @prompt.ask('Select corrisponding number:')
    input = input.to_i unless input.to_i == 0

    case input
    when 1..teams.size
      display_players(teams[input - 1][1])
    when 'h'
      choose_team_help(teams)
      choose_team(teams)
    when 'e'
      exit
    when 'b'
      start
    else
      puts "#{input} is an invalid input"
      puts "ensure input is between [1, #{teams.size}] or press \"h\" for help"
      choose_team(teams)
    end
  end

  def display_players(team)
    puts 'Please select one from the following players or press "h" for help'
    players = FantasyFootballSerieA::Player.choices(team)
    players.each { |player| puts player[0] }
    choose_player(players)
  end

  def choose_player(players)
    input = @prompt.ask('Select corrisponding number:')
    input = input.to_i unless input.to_i == 0

    case input
    when 1..players.size
      player = players[input- 1][1]
      puts "you have selected #{player.name}"
      choose_action(player)
    when 'b'
      display_teams
    when 'h'
      choose_player_help(players)
      choose_player(players)
    when 'e'
      exit
    else
      puts "#{input} is an invalid input"
      puts "ensure input is between [1, #{player.size}] or press \"h\" for help"
    end
  end

  def choose_action(player)
    phrase = 'choose one from the following action'
    choices = [
      { key: "p", name: "print performance", value: 'p' },
      { key: "s", name: "print statistics", value: 's' },
      { key: "i", name: "print info", value: 'i' },
      { key: "v", name: "print recommended price", value: 'v' },
      { key: "u", name: "update player", value: 'u' },
      { key: "b", name: "back to players selection", value: 'b' },
      { key: "e", name: "exit application", value: 'e' }
    ]
    input = @prompt.expand(phrase, choices)

    case input
    when 'p'
      player.display_performance
    when 's'
      player.display_stats
    when 'i'
      player.display_infos
    when 'v'
      player.display_price
    when 'u'
      FantasyFootballSerieA::Scraper.new.update_player(player)
    when 'b'
      display_players(player.team)
    when 'e'
      exit
    end

    choose_action(player)
  end

  def choose_team_help(teams)
    puts "[1, #{teams.size}] - select corrisponding team"
    puts "b - back to start"
    puts "e - exit application"
    puts "h - print help"
  end

  def choose_player_help(players)
    puts "[1, #{players.size}] - select corrisponding player"
    puts "b - back to teams selection"
    puts "e - exit application"
    puts "h - print help"
  end

  def game_description
    puts Rainbow("").blue
    puts Rainbow("fantasy football consist in building a squad by buying 23 real players (3 gk, 8 d, 8 m, 6 a)").blue
    puts Rainbow("off an auction, that is usually done with 6 to 20 players. each matchday, a player has to versus").blue
    puts Rainbow("another by inserting 11 of its 23 players into their teams. based on their performance they").blue
    puts Rainbow("will make a points and at the end of the matchday score are calculated based on the number of point").blue
    puts Rainbow("achieved, with the first goal at 66 pt and then an extra one for every 6 pt (72 pt => 2 goals, 78 => 3,...)").blue
    puts Rainbow("points are calculated like so:").blue
    puts Rainbow("an amount of point that matches the rating of the player for that match(6/10 => 6 pt, 5.5/10 => pt,...)").blue
    puts Rainbow("each goal is +3 pt, assist +1 pt, yellow card -0.5 pt, red card -1 pt, own goal -2 pt,").blue
    puts Rainbow("goal conceded -1 pt (goalkeepers only), penalty saved +3 pt (goalkeepers only), penalty missed -3 pt").blue
    puts Rainbow("").blue
  end

  def app_description
    puts Rainbow("").blue
    puts Rainbow("this app is builded for fantasy managers who wants a way to navigate through players in a faster manner,").blue
    puts Rainbow("avoiding the slow process of finding them on internet, select the link, waiting for the page to render...").blue
    puts Rainbow("this app aims to make this process faster by allowing you to quickly navigate through players to study").blue
    puts Rainbow("their details. this app was originaaly builded to fight one main problem: navigate through players faster").blue
    puts Rainbow("during auctions. it allows you to quicly look up a particular player while you are bidding for him,").blue
    puts Rainbow("making sure that he is worth the credit you are spending. this app also provides you with recommende price").blue
    puts Rainbow("that are calculated on a base of 250 credit, so calculate your recomended price based on your initial credits").blue
    puts Rainbow("(e.g 5/250 => 10/500 => 20/1000). this app also provides you with usefule information such as goal scored,").blue
    puts Rainbow("avg fantasy performance, ... at any time feel free to use \"h\" to see a list of commands that you can use.").blue
    puts Rainbow("my advice is to pratice using this app before your auction, so that you'll be ready to quicly look up any player!!!").blue
    puts Rainbow("").blue
  end

  def update_all_warning
    puts Rainbow("").yellow
    puts Rainbow("------------------------------WARNING-------------------------------").yellow
    puts Rainbow("").yellow
    puts Rainbow("you are about to update the whole database,").yellow
    puts Rainbow("this process will take several minutes").yellow
    puts Rainbow("it is best to run this update only do it after a transfer market!").yellow
    puts Rainbow("to see the up to date details its advised to:").yellow
    puts Rainbow('select a player => run "u" to update the player\'s details').yellow
    puts Rainbow("").yellow
  end

end