class CreateUserReads < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reads do |t|
      t.integer :user_id
      t.integer :node_id

      t.timestamps
    end
  end
end
