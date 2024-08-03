class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items

  scope :on_sale, -> { where(on_sale: true) }
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> { where('updated_at >= ?', 3.days.ago).where.not('created_at >= ?', 3.days.ago) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "stock_quantity", "updated_at", "category_id", "on_sale"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
