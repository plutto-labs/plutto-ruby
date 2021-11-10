require 'plutto/resources/price_logic'

class Plutto::Pricing
  attr_reader :id, :name, :currency, :product_id, :price_logics

  def initialize(
    id:,
    name:,
    currency:,
    product_id:,
    price_logics:,
    **
  )
    @id = id
    @name = name
    @currency = currency
    @product_id = product_id
    @price_logics = price_logics.nil? ? [] : price_logics.map { |data| create_price_logic(data) }
  end

  def to_s
    "Pricing #{name} [#{currency}]"
  end

  private

  def create_price_logic(data)
    Plutto::PriceLogic.new(**data)
  end
end
