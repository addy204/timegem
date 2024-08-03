# app/models/tax_rate.rb
class TaxRate < ApplicationRecord
  validates :province, presence: true
  validates :gst, :pst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "province", "pst", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
