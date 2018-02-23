class CheckedOutItem < ApplicationRecord
	belongs_to :item 
	belongs_to :member

	def self.checked_out_quantity
		  quantity = self.count
	end

end
