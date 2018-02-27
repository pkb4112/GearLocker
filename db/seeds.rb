# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


category_list = [
   "Sleeping Bags",
   "Tents",
   "Backpacks",
   "Stoves",
]

category_list.each do |name|
  Category.create( name: name)
end

item_list = [
  [ "20 Degree Sleeping Bag", "For cold weather",8,1],
  [ "2 Person Tent", "2 people", 4, 2],
  [ "Camp Stove", "Propane", 5, 4],
]

item_list.each do |name, description, quantity, category_id|
  Item.create( name: name, description: description, quantity: quantity, category_id: category_id )
end



member_list = [
  [ "pkb12002","pkb@gmail.com",1],
  [ "mkp59925","mkp@gmail.com",1],
  [ "mlw50012","mlw@gmail.com",1],
  [ "bjh5976","bjh@gmail.com",0],
]

member_list.each do |peoplesoft,email,active|
  Member.create( peoplesoft_number: peoplesoft, email: email, active: active)
end


