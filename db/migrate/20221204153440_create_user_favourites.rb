class CreateUserFavourites < ActiveRecord::Migration[7.0]
  def change
    create_table :user_favourites do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
  end
end
