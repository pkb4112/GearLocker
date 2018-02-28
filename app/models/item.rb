class Item < ApplicationRecord
 #Filterific 
	 filterrific(
   default_filter_params: { sorted_by: 'name_asc' },
   available_filters: [
     :sorted_by,
     :search_query
   ]
 )

	belongs_to :category

	has_many :checked_out_items
	has_many :members, through: :checked_out_items

	#has_many :cart_items
	#has_many :cart_owners, foreign_key: "member_id", class_name: "Member",  through: :cart_items




  scope :checked_out, -> { 
   joins(:checked_out_items).distinct
     }

  scope :checked_in, -> {
  	#Item.where
   where("(items.quantity - (SELECT COUNT(*) FROM items INNER JOIN checked_out_items ON items.id = checked_out_items.item_id)) > 0 ")
  }


  scope :member_items, lambda { |id|
  where('member_id = ?', id)
  }

	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^quantity_/
	    # Simple sort on the created_at column.
	    # Make sure to include the table name to avoid ambiguous column names.
	    # Joining on other tables is quite common in Filterrific, and almost
	    # every ActiveRecord table has a 'created_at' column.
	    order("items.quantity #{ direction }")
	  when /^name_/
	    # Simple sort on the name colums
	    order("LOWER(items.name) #{ direction }, LOWER(items.name) #{ direction }")
	  else
	    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
  }

	def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Quantity Available (Desc)', 'quantity_desc'],
      ['Quantity Available (Asc)', 'quantity_asc'],
    ]
  end

  scope :search_query, lambda { |query|
	  # Searches the items table on the 'name' and 'category' columns.
	  # Matches using LIKE, automatically appends '%' to each term.
	  # LIKE is case INsensitive with MySQL, however it is case
	  # sensitive with PostGreSQL. To make it work in both worlds,
	  # we downcase everything.
	  return nil  if query.blank?

	  # condition query, parse into individual keywords
	  terms = query.downcase.split(/\s+/)

	  # replace "*" with "%" for wildcard searches,
	  # append '%', remove duplicate '%'s
	  terms = terms.map { |e| 
	  	e.prepend('%')
	    (e.gsub('%', '%') + '%').gsub(/%+/, '%')
	  }
	  # configure number of OR conditions for provision
	  # of interpolation arguments. Adjust this if you
	  # change the number of OR conditions.
	
	 num_or_conds = 2
  where(
    terms.map { |term|
      "(LOWER(items.name) LIKE ? OR LOWER(items.name) LIKE ?)"
    }.join(' OR '),
    *terms.map { |term| [term] * num_or_conds }.flatten
    )
  }
 



	def self.get_checked_out_items
		items = Item.joins(:checked_out_items)
	end

	def available_quantity
      quantity = self.quantity - self.checked_out_quantity
	end

	def checked_out_quantity 
		quantity = CheckedOutItem.where("item_id = ?",self.id).count
	end

	def checked_out_to_member_quantity(id)
		member = Member.find(id)
		quantity = CheckedOutItem.where("member_id = ?", id).count(self.id)
	end

end