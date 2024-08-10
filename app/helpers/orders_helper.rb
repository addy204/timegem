# frozen_string_literal: true

module OrdersHelper
  def calculate_taxes(subtotal, province)
    tax_rate = TaxRate.find_by(province:)
    if tax_rate
      gst = tax_rate.gst || 0
      pst = tax_rate.pst || 0
      hst = tax_rate.hst || 0

      taxes = subtotal * (gst + pst + hst)
    else
      taxes = subtotal * 0.05 # Default GST
    end
    taxes
  end
end
