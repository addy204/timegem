class Province < ApplicationRecord
  has_many :addresses
  has_many :users
  has_one :tax_rate, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
