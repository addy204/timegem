# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses
  has_many :users # Ensure users association is present
  has_one :tax_rate, dependent: :destroy # Ensure it uses foreign key

  validates :name, presence: true, uniqueness: true
end
