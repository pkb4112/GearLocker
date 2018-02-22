class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :peoplesoft_number
      t.string :email
      t.boolean :active

      t.timestamps
    end
    add_index :members, :peoplesoft_number
    add_index :members, :email
  end
end
