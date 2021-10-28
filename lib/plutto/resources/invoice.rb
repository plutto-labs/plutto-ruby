module Plutto
  class Invoice
    attr_reader :id, :subtotal_cents, :tax_cents, :discount_cents, :currency, :issue_date,
                :details, :created_at, :updated_at, :customer_id, :status, :payed_at,
                :payment_method, :tax_type, :document_id, :billing_information, :customer_name,
                :customer_email

    # rubocop:disable Metrics/MethodLength
    def initialize(
      id:,
      subtotal_cents:,
      tax_cents:,
      discount_cents:,
      currency:,
      issue_date:,
      details:,
      created_at:,
      customer_id:,
      status:,
      payment_method:,
      tax_type:,
      billing_information:,
      customer_name: nil,
      customer_email: nil,
      updated_at: nil,
      payed_at: nil,
      document_id: nil,
      client: nil,
      **
    )
      @id = id
      @subtotal_cents = subtotal_cents
      @tax_cents = tax_cents
      @discount_cents = discount_cents
      @currency = currency
      @issue_date = Date.parse(issue_date)
      @details = details
      @created_at = Date.parse(created_at)
      @updated_at = Date.parse(updated_at)
      @customer_id = customer_id
      @customer_name = customer_name
      @customer_email = customer_email
      @status = status
      @payed_at = payed_at
      @payment_method = payment_method
      @tax_type = tax_type
      @document_id = document_id
      @billing_information = billing_information
      @client = client
    end
    # rubocop:enable Metrics/MethodLength

    def to_s
      "#{@customer_name.capitalize}'s invoice from #{issue_date.strftime('%d %b %Y')}"
    end
  end
end
