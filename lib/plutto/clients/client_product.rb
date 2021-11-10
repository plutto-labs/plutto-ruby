require 'plutto/resources/product'

class Plutto::ClientProduct < Plutto::Client
  def get_products
    all("products")
  end
end
