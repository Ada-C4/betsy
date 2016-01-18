class Cart

 def self.total(cart)
   total = 0
   cart.each do |product, quantity|
     product = Product.find(product)
     price = product.price.to_i
     total += (price * quantity)
   end
   return total
 end


end
