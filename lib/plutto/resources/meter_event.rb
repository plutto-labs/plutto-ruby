module Plutto
  class MeterEvent
    attr_reader :timestamp, :amount, :action, :id, :meter_id, :created_at,
                :idempotency_key, :customer_id

    def initialize(
      timestamp:,
      amount:,
      action:,
      id: nil,
      meter_id:,
      created_at:,
      customer_id:,
      idempotency_key: nil,
      client: nil,
      **
    )
      @timestamp = Date.parse(timestamp)
      @amount = amount
      @action = action
      @id = id
      @meter_id = meter_id
      @created_at = Date.parse(created_at)
      @idempotency_key = idempotency_key
      @customer_id = customer_id
      @client = client
    end

    def to_s
      "#{action.capitalize} #{amount} to #{meter_id} for #{customer_id}"
    end
  end
end
