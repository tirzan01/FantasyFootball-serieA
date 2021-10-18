class Player < ActiveRecord::Base
  has_one :url_info
  belongs_to :team

end