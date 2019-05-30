class UsersController < Devise::RegistrationsController
    before_action :authenticate_user!, :except => [:create]
    
    def ban
        @to_ban = params[:id_to_ban]
        @user = User.find_by(id: @to_ban)
        @user.update_attribute(:team_id, nil)
        
        redirect_to teamhome_path
    end
    
    def create
        @user_params = params[:user]
        @username = user_params[:username]
        @email = user_params[:email]
        @password = user_params[:password]
        @user = User.new(username: @username, email: @email, password: @password)
        
        if params[:user][:password].length < 8
            flash[:password_error] = "Password is too short"
            redirect_to home_path
            return
        end
        
        if !@user.valid? || params[:user][:password] != params[:user][:password_confirmation]

            flash[:password_error] = "Password must contain at least one number, one uppercase and lowercase letter, at least 8 or more characters and must match with password confirmation\n"+ @user.errors.messages.to_s
            redirect_to home_path
            return
        else
            @user.save
            flash[:good_registration] = "Registration succedeed, confimation email sent!"
            redirect_to home_path
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
