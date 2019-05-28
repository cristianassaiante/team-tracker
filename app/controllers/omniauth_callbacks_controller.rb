class OmniauthCallbacksController < ApplicationController

  def github
    auth = request.env["omniauth.auth"]
    puts auth.inspect
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_create(email: auth.info.nickname + "@github.com", password: Devise.friendly_token[0,20], username: auth.info.nickname)

    user.update( confirmed_at: Time.now.utc, confirmation_token: nil) #No email confirmation required for external authentication services

    sign_in(:user, user)

    redirect_to home_path
  end

end
