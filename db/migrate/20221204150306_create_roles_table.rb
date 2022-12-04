class CreateRolesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :roles_tables do |t|
      t.string :title
      t.string :const

      t.timestamps
    end
  end
end
