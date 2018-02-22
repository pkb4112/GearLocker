class Member < ApplicationRecord
	has_many :checked_out_items
	has_many :items, through: :checked_out_items
end
