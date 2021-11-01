class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :team_id
      t.string :url
      t.string :role
      t.string :dob
      t.integer :height
      t.integer :weight
      t.string :nationality
      t.integer :shirt_number
      t.string :avarage_performance
      t.string :avarage_fantasy_performance
      t.integer :match_played
      t.integer :goals
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :assists
      t.string :penalties
      t.integer :initial_price
      t.integer :price
    end
  end
end