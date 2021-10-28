module Plutto
  class PriceLogic
    attr_reader :id, :type, :price, :price_currency, :meter_count_method, :tiers

    def initialize(
      id:,
      type:,
      price:,
      price_currency:,
      meter_count_method:,
      tiers:,
      **
    )
      @id = id
      @type = type
      @price = price
      @price_currency = price_currency
      @meter_count_method = meter_count_method
      @tiers = tiers
    end

    def to_s
      ""
    end
  end
end
