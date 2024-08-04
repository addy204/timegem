class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer, dependent: :destroy
  has_many :orders, through: :customer
  belongs_to :province, optional: false

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :address, presence: true
  validates :province, presence: true
  validates :username, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at address province_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer orders province]
  end
end
