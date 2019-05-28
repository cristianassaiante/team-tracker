class HomeController < ApplicationController
    
    $twitter_client = Twitter::REST::Client.new do | config |
        config.consumer_key = Rails.application.secrets.twitter_api_key
        config.consumer_secret = Rails.application.secrets.twitter_secret_key
    end
    
    def index
        @tweets =  $twitter_client.search("#ctf", result_type: "recent", lang: "en").first(2)
        @tweets += $twitter_client.search("#defcon", result_type: "recent", lang: "en").first(3)
        @minimum_password_length = 8
    end
    
    def create
        @user_params = params[:user]
        @username = user_params[:username]
        @email = user_params[:email]
        @password = user_params[:password]
        @user = User.new(username: @username, email: @email, password: @password)
        
        if params[:user][:password].length < 8
            puts "Rendering password short"
            flash[:password_error] = "Password is too short"
            redirect_to home_path
            return
        end
        
        if !@user.valid? || params[:user][:password] != params[:user][:password_confirmation]

            flash[:password_error] = "Password must contain at least one number, one uppercase and lowercase letter, at least 8 or more characters and must match with password confirmation"
            redirect_to home_path
            return
        else
            @user.save
            render plain: 'Registrazione avvenuta, email inviata' + @user.to_s
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
