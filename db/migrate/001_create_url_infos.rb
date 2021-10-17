class CreateUrlInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :url_infos do |t|
      t.string :name_url
      t.string :team_url
    end
  end
end