module ProductsHelper
  def status(product)
    product.retire ? "Activate" : "Retire"
  end
end
