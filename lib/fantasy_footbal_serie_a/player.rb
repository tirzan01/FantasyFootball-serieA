class FantasyFootballSerieA::Player < ActiveRecord::Base

  belongs_to :team
  has_one :stat
  has_one :performance
  has_one :value

  def self.choices(team)
    self.all.select{ |p| p.team == team }.map.with_index(1) do |player, i| 
      if i.odd?
        [Rainbow("#{i} - #{player.name}").blue, player]
      else
        ["#{i} - #{player.name}", player]
      end
    end
  end

  def display_infos
    puts ""
    puts "                   D.O.B. =#{self.dob}"
    puts "                   height = #{self.height} cm"
    puts "                   weight = #{self.weight ? "#{self.weight} Kg" : 'n/a'}"
    puts "              nationality =#{self.nationality}"
    puts "             shirt number = #{self.shirt_number}"
    puts ""
  end
  
  def display_price
    puts ""
    puts "initial recommended price = #{self.initial_price} / 250"
    puts "        recommended price = #{self.price} / 250"
    puts ""
  end

  def display_performance
    puts ""
    puts "          avg performance = #{self.avarage_performance}"
    puts "  avg fantasy performance = #{self.avarage_fantasy_performance}"
    puts ""
  end

    puts ""
  def display_stats
    puts ""
    puts "             match played = #{self.match_played}"
    puts "#{display_goals}"
    puts "              yellow card = #{self.yellow_cards}"
    puts "                 red card = #{self.red_cards}"
    puts "                  assists = #{self.assists}"
    puts "#{display_penalties}"
    puts ""
  end

  private

  def display_goals
    if self.role == 'P'
        "           goals conceded = #{self.goals}"
    else
        "                    goals = #{self.goals}"
    end
  end

  def display_penalties
    if self.role == 'P'
        "          penalties saved = #{self.penalties}"
    else
        "                penalties = #{self.penalties}"
    end
  end

end