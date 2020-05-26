class CreateReviews < ActiveRecord::Migration[5.2]
  def change 
    create_table :reviews do |r|
      r.string :user_review
      r.integer :user_rating
      r.integer :user_id
      r.integer :video_game_id
    end
  end
end
