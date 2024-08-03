# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses
  has_many :users # Ensure users association is present

  validates :name, presence: true
end
