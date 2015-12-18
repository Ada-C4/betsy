FactoryGirl.define do
  factory :user do
    username "foo"
    email { "#{username}@example.com" }
    password "foobar"
    password_confirmation "foobar"
  end

  factory :product do
    name "Water bottle"
    price 500
    stock 10
    association :user
  end

  factory :order do
    email "user1@example.com"
    street "1215 4th Ave"
    city "Seattle"
    state "WA"
    zip "98161"
    cc_num "12345678"
    cc_exp Time.now
    cc_cvv "360"
    cc_name "User One"
  end

  factory :review do
    rating 4
    association :product
  end

  factory :orderitem, class: OrderItem do
    quantity 4
    association :order
    association :product
  end

  factory :category do
    name "toy"
  end

end
