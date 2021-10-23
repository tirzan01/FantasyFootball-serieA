class CreateValuesTable < ActiveRecord::Migration[5.2]
    def change
      create_table :values do |t|
        t.integer :player_id
        t.string :initial_value
        t.string :value
      end
    end
  end
