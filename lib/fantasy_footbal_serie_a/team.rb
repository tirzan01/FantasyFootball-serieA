class FantasyFootballSerieA::Team < ActiveRecord::Base
  has_many :players

  def self.choices
    self.all.map.with_index(1) do |t, i|
      if i.odd?
        [Rainbow("#{i} - #{t.name.capitalize}").blue, t]
      else
        ["#{i} - #{t.name.capitalize}", t]
      end
    end
  end

end