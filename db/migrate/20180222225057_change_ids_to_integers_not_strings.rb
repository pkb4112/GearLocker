class ChangeIdsToIntegersNotStrings < ActiveRecord::Migration[5.1]
  def change
  	change_column :checked_out_items, :member_id, 'integer USING CAST(member_id AS integer)'
  	change_column :checked_out_items, :item_id, 'integer USING CAST(item_id AS integer)'
  	change_column :items, :category_id, 'integer USING CAST(category_id AS integer)'

  	
  end
end
