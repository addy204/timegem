class Customer < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :name, :email, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "email", "id", "name", "province_id", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user", "addresses"]
  end
end
