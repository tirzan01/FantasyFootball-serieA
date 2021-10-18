class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :team_id
      t.integer :url_info
      t.text :description
      t.string :info
      t.string :advice
      t.string :stats
    end
  end
end