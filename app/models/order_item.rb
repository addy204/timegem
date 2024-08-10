# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price_at_order, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[id order_id product_id quantity price_at_order created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[order product]
  end
end
