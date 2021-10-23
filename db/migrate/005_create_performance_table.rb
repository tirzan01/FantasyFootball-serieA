class CreatePerformanceTable < ActiveRecord::Migration[5.2]
    def change
      create_table :performance do |t|
        t.integer :player_id
        t.string :avarage_performance
        t.string :avarage_fantasy_performance
      end
    end
  end