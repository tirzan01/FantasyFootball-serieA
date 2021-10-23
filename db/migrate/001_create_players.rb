class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :team_id
      t.integer :url
      t.string :role
      t.string :info_id
      t.string :performance_id
      t.string :stats_id
      t.string :value_id
    end
  end
end