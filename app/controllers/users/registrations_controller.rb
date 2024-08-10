# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb
module Users
  class RegistrationsController < Devise::RegistrationsController
    def update
      super do |resource|
        Rails.logger.error "Validation errors: #{resource.errors.full_messages.join(', ')}" if resource.errors.any?
      end
    end
  end
end
