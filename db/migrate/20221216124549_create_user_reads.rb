class CreateUserReads < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reads do |t|
      t.bigint :user_id
      t.bigint :node_id

      t.timestamps
    end
  end
end
