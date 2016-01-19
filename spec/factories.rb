FactoryGirl.define do
  factory :user do
    first_name "Someone"
    last_name "Else"
    email "7@7.co"
    password "pass"
    password_confirmation "pass"
  end

  factory :order do
    status "pending"
    email "caprina.keller@test.com"
    mailing_address "3158 Union Street, Reisterstown, MD"
    name_on_card "Caprina Keller"
    last_four "1911"
    card_exp Date.today
    zip "22136"
  end

  factory :product do
    name "Fuzzy Wah-Wah pedal"
    description "Making some glorious vintage guitar sounds"
    price 4000
    inventory_total 50
    retired false
    image_url "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg"
    user_id "user.id"
  end

end
