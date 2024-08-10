# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user
  belongs_to :province
  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :province_id, presence: true

  accepts_nested_attributes_for :addresses, allow_destroy: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name email created_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[orders addresses province]
  end
end
