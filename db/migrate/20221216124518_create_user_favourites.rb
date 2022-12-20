class CreateUserFavourites < ActiveRecord::Migration[7.0]
  def change
    create_table :user_favourites do |t|
      t.bigint :user_id
      t.bigint :topic_id

      t.timestamps
    end
  end
end
