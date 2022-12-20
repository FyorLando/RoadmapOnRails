class CreateTopicRates < ActiveRecord::Migration[7.0]
  def change
    create_table :topic_rates do |t|
      t.bigint :topic_id
      t.text :comment
      t.integer :rate
      t.bigint :created_user_id
      t.timestamps
    end
  end
end
