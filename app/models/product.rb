# app/models/product.rb
class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images

  validates :name, :price, :stock_quantity, presence: true

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
