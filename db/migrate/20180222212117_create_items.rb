class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :quantity
      t.string :category_id

      t.timestamps
    end
    add_index :items, :name
  end
end
