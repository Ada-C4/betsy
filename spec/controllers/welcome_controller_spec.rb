require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET index' do
    let(:user_hash) do {
      username: "Burp",
      email_address: "thing@thing.com",
      password: "this",
      password_confirmation: "this"
    }
    end
    let(:second_user_hash) do {
      username: "Ugh",
      email_address: "athing@thing.com",
      password: "this",
      password_confirmation: "this"
    }
    end
    let(:product_hash) do
       {name: "Geometry Like Woahhh",
        price: 5645,
        stock: "1",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    let(:second_product) do
       {name: "Another Product Thing",
        price: 5645245,
        stock: "2",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    let(:third_product) do
       {name: "Another Thing",
        price: 5645245,
        stock: "2",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    let(:fourth_product) do
       {name: "Fourth product",
        price: 56445,
        stock: "2",
        photo_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRDeCvOq-lfd-xau5kCj_RZ5WOD1wldXJybYd9abKVYwZKaGAay",
        description: "I drew this just for you.",
        retired: false
      }
    end
    it 'is successful' do
      user = User.create(user_hash)
      user1 = User.create(second_user_hash)
      cat = Category.create(name: "Cool Shit")
      cat2 = Category.create(name: "Better Shit")
      p = Product.create(product_hash)
      p2 = Product.create(second_product)
      user.products << [p, p2]
      user1.products << [Product.create(third_product), Product.create(fourth_product)]
      cat.products << [p, p2]
      cat2.products << [p, p2]
      get :index
      expect(subject).to render_template :index
    end
  end
end
