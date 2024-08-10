# frozen_string_literal: true

class TaxRate < ApplicationRecord
  belongs_to :province

  validates :gst, :pst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at gst hst id province_id pst updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['province']
  end
end
