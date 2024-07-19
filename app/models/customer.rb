class Customer < ApplicationRecord
  has_many :orders
  has_many :addresses, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
