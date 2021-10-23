class Team < ActiveRecord::Base
  has_many :players
  has_many :url_info, through: :players

  def self.choices
    self.all.map.with_index(1){ |t, i| "#{i} - #{t.name.capitalize}" }
  end

end