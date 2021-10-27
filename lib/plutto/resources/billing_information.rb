module Plutto
  class BillingInformation
    attr_reader :activity, :address, :city, :country_iso_code, :legal_name, :phone, :state,
                :tax_id, :zip, :customer

    def initialize(
      activity:,
      address:,
      city:,
      country_iso_code:,
      legal_name:,
      phone:,
      state:,
      tax_id:,
      zip:,
      customer: nil,
      **
    )
      @activity = activity
      @address = address
      @city = city
      @country_iso_code = country_iso_code
      @legal_name = legal_name
      @phone = phone
      @state = state
      @tax_id = tax_id
      @zip = zip
      @customer = customer
    end

    def to_s
      "#{customer.name.capitalize}'s billing information."
    end
  end
end
