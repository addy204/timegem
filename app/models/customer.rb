class Customer < ApplicationRecord
  has_many :orders
  has_many :addresses, dependent: :destroy

  accepts_nested_attributes_for :addresses

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
