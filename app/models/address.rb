class Address < ApplicationRecord
  belongs_to :customer

  validates :address_line_1, :city, :province, :postal_code, :country, presence: true
end
