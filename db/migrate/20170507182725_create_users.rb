class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role, default: 0

      t.timestamps
    end
    add_index :users, :role
  end
end
