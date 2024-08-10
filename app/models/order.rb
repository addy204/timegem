# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, :customer

  validates :order_status, presence: true
  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  enum order_status: { pending: 0, paid: 1, shipped: 2 }

  before_validation :update_total_and_taxes

  def subtotal
    order_items.sum('quantity * price_at_order')
  end

  def calculate_taxes
    gst = gst_at_order || 0
    pst = pst_at_order || 0
    hst = hst_at_order || 0

    if hst.positive?
      subtotal * hst
    else
      subtotal * (gst + pst)
    end
  end

  def update_total_and_taxes
    self.total = subtotal + calculate_taxes
  end

  def set_tax_rates(province)
    tax_rate = TaxRate.find_by(province_id: province.id)
    self.gst_at_order = tax_rate.gst
    self.pst_at_order = tax_rate.pst
    self.hst_at_order = tax_rate.hst
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[customer order_items]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[order_status total created_at]
  end
end
