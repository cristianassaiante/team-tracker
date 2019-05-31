class UsersController < Devise::RegistrationsController
    before_action :authenticate_user!, :except => [:create]

    def update_resource(resource, params)
        if !current_user.provider.nil?
            resource.update_without_password(params)
        else
            super
        end

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

            flash[:password_error] = "Password must contain at least one number, one uppercase and lowercase letter, at least 8 or more characters and must match with password confirmation\n"
            redirect_to home_path
            return
        else
            @user.save
            flash[:good_registration] = "Registration succedeed, confimation email sent!"
            redirect_to home_path
        end
    end

    def update
        @user = User.find_by(id: current_user.id)

        if params[:user][:email].blank?
            flash[:email_blank_error] = 'Email cannot be blank'
            redirect_to users_settings_path
            return
        end

        @cose = User.find_by(email: params[:user][:email])
        if !@cose.nil? && @cose.id != current_user.id
            flash[:email_exists_error] = "Email already exists"
            redirect_to users_settings_path
            return
        end

        if !params[:user][:password].blank?


            if params[:user][:password].length < 8
                flash[:password_length_error] = "Password is too short"
                redirect_to users_settings_path
                return
            end

            if !params[:user][:password].match(User::PASSWORD_FORMAT)
                flash[:password_error] = 'Password must contain at least one number, one uppercase and lowercase letter, at least 8 or more characters'
                redirect_to users_settings_path
                return
            end

            if params[:user][:password] != params[:user][:password_confirmation]

                flash[:password_match_error] = "Password must match with password confirmation"
                redirect_to users_settings_path
                return
            end

        end

        if !current_user.valid_password?(params[:user][:current_password])
            flash[:current_password_error] = 'Wrong current password'
            redirect_to users_settings_path
            return
        end

        super
        return
    end
    
    private
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
