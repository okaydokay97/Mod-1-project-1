class CreateVideoGames < ActiveRecord::Migration[5.2]
  def change
    create_table :video_games do |v|
      v.string :title
      v.string :genre
      v.string :console
    end
  end
end
