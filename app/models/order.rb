class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, :customer

  validates :order_status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }

  enum order_status: { pending: 0, paid: 1, shipped: 2 }

  def subtotal
    order_items.sum('quantity * price')
  end

  def calculate_taxes
    return 0 unless customer && customer.province

    tax_rate = TaxRate.find_by(province: customer.province.name)
    Rails.logger.debug "Tax Rate for #{customer.province.name}: #{tax_rate.inspect}" # Debug log

    return 0 unless tax_rate

    gst = tax_rate.gst || 0
    pst = tax_rate.pst || 0
    hst = tax_rate.hst || 0

    tax_amount = if hst > 0
                   subtotal * hst
                 else
                   subtotal * (gst + pst)
                 end
    Rails.logger.debug "Calculated Tax Amount: #{tax_amount}" # Debug log

    tax_amount
  end

  def total
    subtotal + calculate_taxes
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer order_items]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[order_status total created_at]
  end
end
