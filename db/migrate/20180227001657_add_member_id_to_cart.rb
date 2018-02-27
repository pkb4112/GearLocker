class AddMemberIdToCart < ActiveRecord::Migration[5.1]
  def change

  	add_column :carts, :member_id, :integer
  end
end
