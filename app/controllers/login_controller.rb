class LoginController < ApplicationController
    
    def index
    end
    
    def create
        @email = params[:user][:email]
        @password = params[:user][:password]
        @user = @email.present? && User.find_by(email: @email)
        if @user && @user.valid_password?(@password)
            @user.remember_me = params[:user][:remember_me] == '0' ? false : true
            sign_in(@user)
            
            redirect_to home_path
        else
            flash[:login_error] = @user ? "Please confirm your email" : "Invalid email or password"
            redirect_to '/login'
        end
    end
    
    def destroy
        sign_out(@user)
        redirect_to home_path
    end
    
    def new
        redirect_to '/login'
    end
end
