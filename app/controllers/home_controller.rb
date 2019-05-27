class HomeController < ApplicationController
    
    def index
        @tweets = []
    end
    
    def create
        @user_params = params[:user]
        @username = user_params[:username]
        @email = user_params[:email]
        @password = user_params[:password]
        @user = User.new(username: @username, email: @email, password: @password)
        
        if !@user.valid? || !params[:user][:password] == params[:user][:password_confirmation]
            render plain: 'registrazione non riuscita'
        else
            @user.save
            render plain: 'registrazione avvenuta, email inviata' + @user.to_s
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
