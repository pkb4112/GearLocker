class CartsController < ApplicationController

	
 def add_to_cart
    @member = Member.find(params[:member_id])
    @item = Item.find(params[:item_id])
    @member.cart << @item 
  end

  def remove_from_cart
    @member = Member.find(params[:member_id])
    @item = Item.find(params[:item_id])
    @member.cart.item.delete 
  end

  def cart
    @member = Member.find(params[:id])
    @cart = @member.cart
    @filterrific = initialize_filterrific(
      Item,
      params[:filterrific],
      select_options: {
        sorted_by: Item.options_for_sorted_by,
      },
      #persistence_id: 'shared_key',
      default_filter_params: {},
    ) or return
    # Get an ActiveRecord::Relation for all students that match the filter settings.
    # You can paginate with will_paginate or kaminari.
    # NOTE: filterrific_find returns an ActiveRecord Relation that can be
    # chained with other scopes to further narrow down the scope of the list,
    # e.g., to apply permissions or to hard coded exclude certain types of records.
    @items = @cart.items.page(params[:page])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end
  end

end
