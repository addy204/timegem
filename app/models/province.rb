# app/models/province.rb
class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
end
