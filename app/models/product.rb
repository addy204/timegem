class Product < ApplicationRecord
  belongs_to :category
  has_many_attached :images

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "name", "price", "stock_quantity", "updated_at", "category_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end
end
