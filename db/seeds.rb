# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
# require 'pry'

tables = {
  "Category" => './seeds_csvs/categories.csv',
  "Order" => './seeds_csvs/orders.csv',
  "Product" => './seeds_csvs/products.csv',
  "User" => './seeds_csvs/users.csv',
  "Review" => './seeds_csvs/reviews.csv',
  'OrderItem' => './seeds_csvs/order_items.csv'
  }

tables.each do |k, v|
  data = CSV.read(v, :headers => true, :header_converters => :symbol).map{ |row| row.to_hash }
  data.each do |info|
    if k == "Order"
      o = Order.new(info)
      o.cc_exp = Time.now
      o.save
    elsif k == "Category"
      Category.create(info)
    elsif k == "Product"
      p = Product.create(info)
      a = Array.new(rand(1..5)){ |i| i = rand(1..10) }
      p.categories << Category.find(a.uniq)
    elsif k == "User"
      User.create(info)
    elsif k == "Review"
      Review.create(info)
    elsif k == "OrderItem"
      OrderItem.create(info)
    end
  end
end
