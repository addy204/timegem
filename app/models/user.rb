class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer, dependent: :destroy
  has_many :orders, through: :customer
  belongs_to :province, optional: true

  validates :address, presence: true
  validates :province, presence: true
end
