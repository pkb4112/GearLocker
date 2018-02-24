class Member < ApplicationRecord

	 filterrific(
   default_filter_params: { sorted_by: 'peoplesoft_number_asc' },
   available_filters: [
     :sorted_by,
     :search_query,
     :with_active
   ]
 )

	has_many :checked_out_items
	has_many :items, through: :checked_out_items

	scope :sorted_by, lambda { |sort_option|
	  # extract the sort direction from the param value.
	  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
	  case sort_option.to_s
	  when /^peoplesoft_/
	    # Simple sort on the created_at column.
	    # Make sure to include the table name to avoid ambiguous column names.
	    # Joining on other tables is quite common in Filterrific, and almost
	    # every ActiveRecord table has a 'created_at' column.
	    order("members.peoplesoft_number #{ direction }")
	  when /^email_/
	    # Simple sort on the name colums
	    order("LOWER(members.email) #{ direction }, LOWER(members.email) #{ direction }")
	  else
	   raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
	  end
}

	# filters on 'gender' attribute
	scope :with_active, lambda { |flag|
		return nil if 0 == flag #checkbox unchecked
	  where(active: 1)
	}

	def self.options_for_sorted_by
    [
      ['Email (a-z)', 'email_asc'],
      ['PeopleSoft Number (Desc)', 'peoplesoft_number_desc'],
      ['PeopleSoft Number  (Asc)', 'peoplesoft_number_asc'],
    ]
  end

  def self.options_for_select
  	  "Active Member"
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
	      "(LOWER(members.peoplesoft_number) LIKE ? OR LOWER(members.email) LIKE ?)"
	    }.join(' OR '),
	    *terms.map { |term| [term] * num_or_conds }.flatten
	  )
	}





	def get_items
       @items = self.items
   end


end
