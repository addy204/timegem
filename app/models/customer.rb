# app/models/customer.rb
class Customer < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :name, :email, presence: true

  accepts_nested_attributes_for :addresses, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name email created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[orders addresses province]
  end
end
