# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

seed_categories = [
  { name: "Wands" },
  { name: "School Supplies" },
  { name: "Dark Objects" },
  { name: "Prank Items" },
  { name: "Robes" },
  { name: "Animals" },
  { name: "Quidditch" },
  { name: "Sweets" }
]

seed_categories.each do |seed|
  Category.create(seed)
end

seed_merchants = [
  { user_name: "Ollivanders", email: "ollie@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "George Weasley", email: "RIPfred@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Flourish and Blotts", email: "booksandwands@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Borgin and Burkes", email: "antiques@knockturnalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Honeydukes", email: "sweets@hogsmeade.com", password: "p", password_confirmation: "p" },
  { user_name: "Quality Quidditch Goods", email: " ", password: "p", password_confirmation: "p" },
  { user_name: "Magical Menagerie", email: "animals@diagonalley.com", password: "p", password_confirmation: "p" },
  { user_name: "Madam Malkin's", email: "robes@diagonalley.com", password: "p", password_confirmation: "p" }
]

seed_merchants.each do |seed|
  Merchant.create(seed)
end

seed_products = [
  { name: "Wand", price: 50, merchant_id: 1, description: "Core of unicorn tail", photo_url: "http://vignette3.wikia.nocookie.net/harrypotter/images/a/ad/George_Weasley's_wand.jpg/revision/latest?cb=20110503105406", inventory: 100, retire: false },
  { name: "Cauldron", price: 50, merchant_id: 3, description: "Solid. Made in Romania ", photo_url: "http://www.madvapes.com/media/catalog/product/cache/1/image/9df78eab33525d08d6e5fb8d27136e95/c/a/cauldron.jpg", inventory: 24, retire: false },
  { name: "Extendable Ears", price: 30, merchant_id: 2, description: "Sneak a listen at a distance", photo_url: "http://www.kimlawlercreative.com/wp-content/uploads/2011/06/extendable-ear.jpg", inventory: 20, retire: false },
  { name: "Horcrux", price: 500000, merchant_id: 4, description: "A piece of the puzzle - the ring", photo_url: "http://ecx.images-amazon.com/images/I/41vRx1M8JTL._SY300_.jpg", inventory: 1, retire: true },
  { name: "Firebolt 5", price: 1000, merchant_id: 6, description: "The finest of them all, the Firebolt 5 is faster than ever.", photo_url: "http://ii.wbshop.com/fcgi-bin/iipsrv.fcgi?FIF=/images/warnerbros/source/warnerbros/hpnbbroom.tif&wid=370&cvt=jpeg", inventory: 5, retire: false },
  { name: "Bertie Bott's", price: 5, merchant_id: 5, description: "Delicious, disgusting treats for your friends and foes", photo_url: "http://cdn-tp1.mozu.com/9046-11441/cms/11441/files/35cdea6c-8cbb-490b-97d4-be3c2fc55840", inventory: 30, retire: false },
  { name: "Cat", price: 500, merchant_id: 7, description: "She will purr in your lap and eat your rats", photo_url: "http://i.stack.imgur.com/dgcXv.png", inventory: 10, retire: false },
  { name: "Dress Robe", price: 100, merchant_id: 8, description: "A desirable robe for your finest of occasion.", photo_url: "http://images.halloweencostumes.com/products/7538/1-2/replica-harry-potter-slytherin-robe.jpg", inventory: 10, retire: false },
  { name: "Robe", price: 80, merchant_id: 8, description: "A desirable robe for everyday wear.", photo_url: "http://i684.photobucket.com/albums/vv208/lovexrwf/Wizard%20Robes/cloakseller_01/1.jpg", inventory: 10, retire: false },
  { name: "Elder Wand", price: 80000, merchant_id: 1, description: "Straight from Dumbledore's tomb. Core of thestral hair.", photo_url: "http://vignette4.wikia.nocookie.net/harrypotter/images/7/7d/Elder_wand.jpg/revision/latest?cb=20110721103117", inventory: 10, retire: false },
  { name: "Quill", price: 20, merchant_id: 3, description: "Durable, Made in Great Britain.", photo_url: "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=15030537", inventory: 10, retire: false },
  { name: "Frog", price: 30, merchant_id: 7, description: "Get your first year a gift they're sure to misplace, time and time again..", photo_url: "http://internal.adu.org.za/upload/uploads/20120628_kznmidlands_commonriverfrog_trevor_hardaker.jpg", inventory: 10, retire: false },
  { name: "Lemon Drops", price: 8, merchant_id: 5, description: "Dumbledore's favorite. Need we say more?", photo_url: "https://c2.staticflickr.com/2/1240/782790587_9c70da2bac.jpg", inventory: 100, retire: false }
]

seed_products.each do |seed|
  Product.create(seed)
end

seed_order_items = [
  { product_id: 1, order_id: 7, quantity: 1, shipped: false },
  { product_id: 1, order_id: 10, quantity: 1, shipped: false },
  { product_id: 7, order_id: 1, quantity: 1, shipped: false },
  { product_id: 2, order_id: 1, quantity: 1, shipped: false },
  { product_id: 3, order_id: 4, quantity: 3, shipped: false },
  { product_id: 4, order_id: 1, quantity: 1, shipped: false },
  { product_id: 3, order_id: 5, quantity: 1, shipped: false },
  { product_id: 8, order_id: 6, quantity: 1, shipped: false },
  { product_id: 6, order_id: 7, quantity: 1, shipped: false },
  { product_id: 5, order_id: 8, quantity: 1, shipped: false },
  { product_id: 3, order_id: 9, quantity: 1, shipped: false },
  { product_id: 5, order_id: 10, quantity: 1, shipped: false }
]

seed_order_items.each do |seed|
  OrderItem.create(seed)
end

seed_orders = [

  { status: "pending", order_time: Time.now, customer_name: "Minerva McGonagall", customer_email: "minverva@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Minerva McGonagall"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com",street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Lucius Malfoy", customer_email: "iheartvoldy@dark.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Lucius Malfoy" },
  { status: "pending", order_time: Time.now, customer_name: "Molly Weasley", customer_email: "burrowbad-ass@magic.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Molly Weasley" },
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"},
  { status: "pending", order_time: Time.now, customer_name: "Severus Snape", customer_email: "severus@hogwarts.com", street_address: "Hogwarts Castle", zip_code: 12345, state: "Washington", city: "Hogwarts", card_number: 1234, customer_card_exp_month: 10, customer_card_exp_year: 2018, security_code: 123, name_on_card: "Severus Snape"}
]

seed_orders.each do |seed|
  Order.create(seed)
end

status_array = ["paid", "cancelled"]

Order.last(5).each do |order|
  order.update_attribute(:status, status_array[rand(0..1)] )
end

seed_categories_products = [
  { product_id: 1 , category_id: 1 },
  { product_id: 2 , category_id: 2 },
  { product_id: 3 , category_id: 4 },
  { product_id: 4 , category_id: 3 },
  { product_id: 5, category_id: 7 },
  { product_id: 6, category_id: 8 },
  { product_id: 7, category_id: 6 },
  { product_id: 8, category_id: 5 },
  { product_id: 9, category_id: 5 },
  { product_id: 10, category_id: 1 },
  { product_id: 11, category_id: 2 },
  { product_id: 12, category_id: 6 },
  { product_id: 13, category_id: 8 }

]

seed_categories_products.each do |seed|
  CategoriesProduct.create(seed)
end

seed_reviews = [
  { rating: 5, product_id: 1, description: "Amazing quality for the price.  Lightweight with a perfect balance for my wee little wizard's first year at Hogwart's" },
  { rating: 2, product_id: 2, description: "Horrible to clean. Spent hours scraping flobberworm mucus from the bottom" },
  { rating: 3, product_id: 3, description: "doesn't fit, emits creepy indistinct whispers" },
  { rating: 5, product_id: 4, description: "Has skyrocketed my sleuthing Slytherin skills to a stupendous state!" },
  { rating: 1, product_id: 6, description: "They messed up and gave me only vomit flavoured beans! Completely Horrid! Avoid at all costs!" },
  { rating: 1, product_id: 5, description: "My daddy bought me this so I could beat Potter but it is horrible. Haven't beaten him once - I'm returning it." },
  { rating: 1, product_id: 8, description: "Me mum made me wear these. Bloody miserable, they were. My date wouldn't even look at me." },
  { rating: 5, product_id: 7, description: "I have one just like her. She's the only one that really understands me." }
]

seed_reviews.each do |seed|
  Review.create(seed)
end
