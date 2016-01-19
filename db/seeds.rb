# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
seed_categories = [
  { name: "stuffed animals" },
  { name: "stickers" },
  { name: "clothing" },
  { name: "slippers" },
  { name: "people"},
  { name: "live animals"}
]

seed_categories.each do |seed|
  Category.create(seed)
end

seed_users = [
  { first_name: "Daphne", last_name: "Gold", email: "1@1.com" },
  { first_name: "Amy", last_name: "Hunter", email: "2@2.com" },
  { first_name: "Jessica", last_name: "Noglows", email: "3@3.com" },
  { first_name: "Lauren", last_name: "Granger", email: "4@4.com" },
  { first_name: "Charles", last_name: "Ellis", email: "5@5.com" },
  { first_name: "Kari", last_name: "Bancroft", email: "6@6.com" }
]

seed_users.each do |seed|
  user = User.create(seed)
  user.password = "1"
  user.save
end

seed_products = [
  {name: "Fuzzy Bunny", description: "A bunny that is fuzzy", price: 1000, inventory_total: 15, retired: false, image_url: "https://img1.etsystatic.com/016/0/5209660/il_fullxfull.418850207_s1jz.jpg", user_id: 1, :categories => Category.where(:name => ['stuffed animals'])},
  {name: "Fuzzy Wozniack", description: "A fuzzy computer guy", price: 5000, inventory_total: 1, retired: false, image_url: "http://rack.0.mshcdn.com/media/ZgkyMDEyLzEyLzA0LzVmL3N0ZXZld296bmlhLmMzUy5qcGcKcAl0aHVtYgkxMjAweDYyNyMKZQlqcGc/04902e3b/343/steve-wozniak-on-steve-jobs-videos--e2d1864990.jpg", user_id: 2, :categories => Category.where(:name => ['people'])},
  {name: "Fozzie Was-he", description: "A muppet that tells dad jokes", price: 3000, inventory_total: 5, retired: false, image_url: "http://vignette1.wikia.nocookie.net/muppet/images/b/be/Fozzie-pose-60percent.png/revision/latest?cb=20131219191526", user_id: 3, :categories => Category.where(:name => ['stuffed animals', 'stickers'])},
  {name: "Fonzie Was-he", description: "Eeeeyyyyyyy", price: 2000, inventory_total: 8, retired: false, image_url: "http://digilander.libero.it/happydays/foto_attori/fonzie/hdc1.jpg", user_id: 4, :categories => Category.where(:name => ['people', 'socks'])},
  {name: "Fuzzy Wah-Wah pedal", description: "Making some glorious vintage guitar sounds", price: 4000, inventory_total: 50, retired: false, image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg", user_id: 2, :categories => Category.where(:name => ['stuffed animals',  'slippers'])},
  {name: "Fun Size Whatchamacallit", description: "Caaaaaaaaandy", price: 500, inventory_total: 2000, retired: false, image_url: "http://ecx.images-amazon.com/images/I/41kHr2%2BU6XL._SL500_AA300_.jpg", user_id: 1, :categories => Category.where(:name => ['stuffed animals', 'clothing'])},
  {name: "Giant Scary Bear", description: "This is to test if orders are working as expected", price: 500, inventory_total: 2000, retired: false, image_url: "http://www.annsheybani.com/wp-content/uploads/2012/12/bear.jpg", user_id: 3, :categories => Category.where(:name => ['stuffed animals', 'clothing'])},
  {name: "Intimidating Bear", description: "This is the second item to test if orders are working as expected", price: 800, inventory_total: 100, retired: false, image_url: "http://3.bp.blogspot.com/_W90V87w3sr8/TSdKsMMbdsI/AAAAAAAAAmY/DZq_8pArw2g/s1600/brown_bear_3.png", user_id: 4, :categories => Category.where(:name => ['stuffed animals', 'clothing'])},
  {name: "Fuzzy Dice", description: "Hang them in your car! Hang them in your friend's car!", price: 1000, inventory_total: 50, retired: false, image_url: "http://hawkhardware.com/images/c5038r.jpg", user_id: 6, :categories => Category.where(:name => ['stickers', 'live animals'])},
  {name: "Fuzzy Hot-Pink Slippers", description: "For cozzy feet time!", price: 800, inventory_total: 15, retired: false, image_url: "http://flipflopsandalz.com/wp-content/uploads/2015/02/Fuzzy-Flip-Flop-Slippers.jpg", user_id: 5, :categories => Category.where(:name => ['slippers', 'clothing'])}
]

seed_products.each do |seed|
  Product.create(seed)
end

seed_reviews = [
  {rating: 3, review_text: "Adorable, but the jokes got real old real fast", product_id: 3 },
  {rating: 5, review_text: "He is too cool for school. Everyone loves the Fonz!", product_id: 4 },
  {rating: 1, review_text: "This made my guitar sound fuzzy, but the pedal itself wasn't fuzzy, which was a total bummer.", product_id: 5 },
  {rating: 2, review_text: "I liked the calls, but not the whats, the mas, or the its in this candy bar. Reeses are better", product_id: 6 },
  {rating: 4, review_text: "This bunny was really fuzzy. I would have liked just a little more fuzz. I'm picky.", product_id: 1 },
  {rating: 5, review_text: "Gotta love the Woz", product_id: 2 }
]

seed_reviews.each do |seed|
  Review.create(seed)
end

seed_orders = [

  { status: "pending", email: "caprina.keller@test.com", mailing_address: "3158 Union Street, Reisterstown, MD", name_on_card: "Caprina Keller", last_four: "1911", card_exp: Date.today, zip: "22136"
  },

  { status: "paid", email: "brennan.vanleeuwenhoek@test.com", mailing_address: "8660 Cherry Street, Cumming, GA ", name_on_card: "Brennan Van Leeuwenhoek", last_four: "7751", card_exp: Date.today + 3, zip: "30040"
  },

  { status: "paid", email: "alfarr.shine@test.com", mailing_address: "3040 Fairway Drive, Eden Prairie, MN", name_on_card: "Alfar Shine", last_four: "2278", card_exp: Date.new(2016, 3), zip: "55347"
  },

  { status: "paid", email: "hanibal.darrow@test.com", mailing_address: "3117 New Street, Feasterville Trevose, PA", name_on_card: "Hannibal Darrow", last_four: "2173", card_exp: Date.new(2017, 5), zip: "19053"
  },

  { status: "complete", email: "umberto.mikkelsen@test.com", mailing_address: "9290 Chestnut Street, Winder, GA", name_on_card: "Umberto Mikkelsen", last_four: "3595", card_exp: Date.new(2018, 1), zip: "30680"
  },

  { status: "paid", email: "iephthae.jokumsen@test.com", mailing_address: "2367 Pin Oak Drive, Brookline, MA", name_on_card: "Iephthae  Jokumsen", last_four: "6641", card_exp: Date.new(2016, 2), zip: "02446"
  },

  { status: "paid", email: "test@test.com", mailing_address: "2367 Pin Oak Drive, Brookline, MA", name_on_card: "Iephthae  Jokumsen", last_four: "6641", card_exp: Date.new(2016, 2), zip: "02446"}

]

seed_orders.each do |seed|
  Order.create(seed)
end

seed_order_items = [
  { quantity: 1, order_id: 3, product_id: 2 },
  { quantity: 6, order_id: 1, product_id: 6 },
  { quantity: 2, order_id: 2, product_id: 4 },
  { quantity: 4, order_id: 4, product_id: 5 },
  { quantity: 3, order_id: 5, product_id: 6 },
  { quantity: 2, order_id: 3, product_id: 2 },
  { quantity: 7, order_id: 1, product_id: 5 },
  { quantity: 2, order_id: 4, product_id: 1 },
  { quantity: 5, order_id: 6, product_id: 6 },
  { quantity: 4, order_id: 4, product_id: 6 },
  { quantity: 5, order_id: 6, product_id: 6 },
  { quantity: 4, order_id: 4, product_id: 6 },
  { quantity: 3, order_id: 7, product_id: 7 },
  { quantity: 4, order_id: 7, product_id: 8}
]

seed_order_items.each do |seed|
  OrderItem.create(seed)
end
