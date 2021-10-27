require 'plutto/resources/pricing'

module Plutto
  class Subscription
    attr_reader :id, :customer_id, :created_at, :updated_at, :active, :trial_finishes_at,
                :bills_at, :billing_period_duration, :pricings, :permission_group

    def initialize(
      id:,
      customer_id:,
      created_at:,
      updated_at:,
      active:,
      trial_finishes_at:,
      bills_at:,
      billing_period_duration:,
      pricings:,
      permission_group: nil,
      **
    )
      @id = id
      @customer_id = customer_id
      @created_at = Date.parse(created_at)
      @updated_at = Date.parse(updated_at)
      @active = active
      @trial_finishes_at = trial_finishes_at
      @bills_at = bills_at
      @billing_period_duration = billing_period_duration
      @pricings = pricings.nil? ? [] : pricings.map { |data| create_pricing(data) }
      @permission_group = permission_group
    end

    def to_s
      "#{customer_id} is subscribed since #{created_at.strftime('%d %b %Y')}"
    end

    private

    def create_pricing(data)
      Plutto::Pricing.new(**data)
    end
  end
end
