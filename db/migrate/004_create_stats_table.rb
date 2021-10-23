class CreateStatsTable < ActiveRecord::Migration[5.2]
    def change
      create_table :stats do |t|
        t.integer :player_id
        t.string :match_played
        t.string :goals_cored
        t.string :yellow_cards
        t.string :red_cards
        t.string :assists
        t.string :penalties
      end
    end
  end