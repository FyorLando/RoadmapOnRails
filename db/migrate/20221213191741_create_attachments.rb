class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.bigint :node_id
      t.text :url
      t.timestamps
    end
  end
end
