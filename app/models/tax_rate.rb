class TaxRate < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst", "hst", "id", "province", "pst", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
