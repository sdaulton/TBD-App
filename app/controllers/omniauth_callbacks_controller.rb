class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
      if @user.first.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        redirect_to  welcome_user_path(@user.first)
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration
      end
  end
end
