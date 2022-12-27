class ChangeColumnTypeUserRead < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_reads, :node_id, :bigint
    add_column :user_reads, :topic_id, :bigint
  end
end
