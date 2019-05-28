class LoginController < ApplicationController
    
    def index
        
    end
    
    def create
        @email = params[:user][:email]
        @password = params[:user][:password]
        @user = @email.present? && User.find_by(email: @email)
        puts "CALLED CREATE"
        if @user && @user.valid_password?(@password)
            #flash[:logged_in] = "Logged in as " + @user.username
            @user.remember_me = params[:user][:remember_me] == '0' ? false : true
            sign_in(@user)
            
            if @user.team
                redirect_to home_path           # provvisory
            else
                redirect_to home_path
            end
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
