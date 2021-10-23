class Player < ActiveRecord::Base
  has_one :url_info
  belongs_to :team

  def self.choices(team)
    self.all.select{ |p| p.team == team }.map.with_index(1){ |player, i| ["#{i} - #{player.name}", player]}
  end

end