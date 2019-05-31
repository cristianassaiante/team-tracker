class OmniauthCallbacksController < ApplicationController

  def github
    auth = request.env["omniauth.auth"]
    puts auth.inspect
    user = User.where(provider: auth.provider, uid: auth.uid).first_or_create(email: auth.info.nickname + "@github.com", password: Devise.friendly_token[0,20], username: auth.info.nickname)

    sign_in(:user, user)

    redirect_to home_path
  end

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth.provider, uid: auth.uid)
               .first_or_create(email: auth.info.email, password: Devise.friendly_token[0,20], username: auth.info.name, provider: 'google')

    sign_in(:user, user)

    redirect_to home_path

  end

end
