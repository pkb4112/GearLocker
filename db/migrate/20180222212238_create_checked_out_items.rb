class CreateCheckedOutItems < ActiveRecord::Migration[5.1]
  def change
    create_table :checked_out_items do |t|
      t.string :item_id
      t.string :member_id

      t.timestamps
    end
  end
end
