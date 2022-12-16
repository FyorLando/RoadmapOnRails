class CreateNodeRates < ActiveRecord::Migration[7.0]
  def change
    create_table :node_rates do |t|
      t.bigint :node_id
      t.text :comment
      t.integer :rate
      t.timestamps
    end
  end
end
