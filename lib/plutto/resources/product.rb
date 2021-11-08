require 'plutto/resources/pricing'

module Plutto
  class Product
    attr_reader :id, :name, :meter, :pricings

    def initialize(
      id:,
      name:,
      meter:,
      pricings:,
      client: nil,
      **
    )
      @id = id
      @client = client
      @name = name
      @meter = meter
      @pricings = pricings.nil? ? [] : pricings.map { |data| create_pricing(data) }
    end

    def to_s
      "Product: #{name.capitalize}"
    end

    private

    def create_pricing(data)
      Plutto::Pricing.new(**data)
    end
  end
end
