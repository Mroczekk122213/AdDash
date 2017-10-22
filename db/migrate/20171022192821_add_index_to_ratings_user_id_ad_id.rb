class AddIndexToRatingsUserIdAdId < ActiveRecord::Migration[5.1]
  def change
    add_index :ratings, [:user_id, :ad_id], unique: true
  end
end
