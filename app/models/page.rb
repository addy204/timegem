class Page < ApplicationRecord
  # Define ransackable attributes for Ransack search
  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at updated_at]
  end
end
