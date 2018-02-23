class Item < ApplicationRecord
	belongs_to :category
	has_many :checked_out_items
	has_many :members, through: :checked_out_items

	def self.get_checked_out_items
		items = Item.joins(:checked_out_items)
	end

	def available_quantity
      quantity = self.quantity - self.checked_out_quantity
	end

	def checked_out_quantity 
		quantity = CheckedOutItem.count(self.id)
	end

end
