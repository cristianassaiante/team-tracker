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
            if !@user
                flash[:login_error] = "Email not valid"
            else
                if @user.confirmed_at
                    flash[:login_error] = "Invalid email or password"
                else
                    flash[:login_error] = "P"
                end
            end
            redirect_to login_path
        end
    end
    
    def destroy
        sign_out(@user)
        redirect_to home_path
    end
    
    def new
        redirect_to login_path
    end
end
