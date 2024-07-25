class Order < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'user_id'
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, :customer

  validates :status, :total, presence: true

  def total
    order_items.sum('quantity * price') + calculate_taxes
  end

  def calculate_taxes
    subtotal = order_items.sum('quantity * price')
    return 0 unless customer && customer.addresses.any?

    province = customer.addresses.first.province
    tax_rate = TaxRate.find_by(province: province)
    return 0 unless tax_rate

    gst = tax_rate.gst_rate
    pst = tax_rate.pst_rate
    hst = tax_rate.hst_rate

    if hst.present?
      subtotal * hst / 100
    else
      subtotal * gst / 100 + subtotal * pst / 100
    end
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer order_items]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[status total created_at updated_at]
  end
end
