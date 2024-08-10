# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at description id name updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['products']
  end
end
