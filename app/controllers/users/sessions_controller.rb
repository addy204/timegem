# app/controllers/users/sessions_controller.rb
module Users
  class SessionsController < Devise::SessionsController
    # DELETE /resource/sign_out
    def destroy
      super
    end
  end
end
