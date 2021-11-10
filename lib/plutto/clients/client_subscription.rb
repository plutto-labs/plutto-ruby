require 'plutto/resources/subscription'

class Plutto::ClientSubscription < Plutto::Client
  def create_subscription(**params)
    post('subscriptions', **params)
  end

  def end_subscription(subscription_id:)
    patch("subscriptions/#{subscription_id}/end_subscription")
  end

  def add_pricings(subscription_id:, **params)
    patch("subscriptions/#{subscription_id}/add_pricings", **params)
  end

  def remove_pricings(subscription_id:, **params)
    patch("subscriptions/#{subscription_id}/remove_pricings", **params)
  end
end
