class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, :customer

  validates :status, :total, presence: true
end
