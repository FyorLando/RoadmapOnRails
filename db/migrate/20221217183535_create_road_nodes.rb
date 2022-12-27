class CreateRoadNodes < ActiveRecord::Migration[7.0]
  def change
    create_table :road_nodes do |t|
      t.bigint :parent_id
      t.string :title
      t.text :description
      t.bigint :topic_id

      t.timestamps
    end
  end
end
