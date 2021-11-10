require 'plutto/resources/invoice'

class Plutto::ClientInvoice < Plutto::Client
  include Plutto::Utils
  def get_invoices(q_status:, q_customer:)
    suffix = Plutto::Utils.concat_query_to_url(q_status, q_customer)
    all("invoices#{suffix}")
  end

  def get_invoice(invoice_id:)
    get("invoices/#{invoice_id}")
  end

  def invoice_mark_as(invoice_id:, **params)
    patch("invoices/#{invoice_id}/mark_as", **params)
  end
end
