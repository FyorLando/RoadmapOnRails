class CreateUserRead < ActiveRecord::Migration[7.0]
  def change
    create_table :user_read do |t|
      t.integer :user_id
      t.integer :node_id

      t.timestamps
    end
  end
end
