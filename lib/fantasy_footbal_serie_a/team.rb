class FantasyFootballSerieA::Team < ActiveRecord::Base
  has_many :players

  def self.choices
    self.all.map.with_index(1){ |t, i| ["#{i} - #{t.name.capitalize}", t] }
  end

end