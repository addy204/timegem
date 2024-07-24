# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  def update
    super do |resource|
      if resource.errors.any?
        Rails.logger.error "Validation errors: #{resource.errors.full_messages.join(", ")}"
      end
    end
  end
end
