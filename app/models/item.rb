class Item < ApplicationRecord
	belongs_to :category
	has_many :checked_out_items
	has_many :members, through: :checked_out_items
end
