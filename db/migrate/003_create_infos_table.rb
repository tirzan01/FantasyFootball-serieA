class CreateInfosTable < ActiveRecord::Migration[5.2]
    def change
      create_table :info do |t|
        t.integer :player_id
        t.string :dob
        t.string :height
        t.string :weight
        t.string :nationality
        t.string :shirt_number
      end
    end
  end
  