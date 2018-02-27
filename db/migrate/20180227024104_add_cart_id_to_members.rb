class AddCartIdToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :cart_id, :integer
  end
end
