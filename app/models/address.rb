class Address < ApplicationRecord
  belongs_to :customer
  belongs_to :province

  validates :address_line_1, :city, :postal_code, :country, :province_id, presence: true
  validates :postal_code, format: { with: /\A[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d\z/, message: "is invalid" }
end
