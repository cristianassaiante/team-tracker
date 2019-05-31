class ProfileController < ApplicationController
        before_action :authenticate_user!
    
    def index
        if !current_user.team_id
            flash[:create_error] = "You have to create a team before access the team home"
            flash[:join_error] = "You have to join a team before access the team home"
            redirect_to home_path
            return
        end
        @team = Team.find_by(id: current_user.team_id)
    end

        def update
            if params[:user][:username].blank?
                flash[:username_blank_error] = "Username cannot be blank"
                redirect_to users_profile_path
                return
            end

            @cose = User.find_by(username: params[:user][:username])
            if !@cose.nil? && @cose.id != current_user.id
                flash[:username_exist_error] = "Username already exists"
                redirect_to users_profile_path
                return
            end

            if !params[:user][:website].match('[a-z0-9.-]+\.[a-z]{2,}$')
                flash[:website_error] = 'Wrong website format'
                redirect_to users_profile_path
                return
            end


            if params[:user][:school].blank?
                current_user.update_without_password({username: params[:user][:username], website: params[:user][:website], age: params[:user][:age]})
            else
                current_user.update_without_password({username: params[:user][:username], website: params[:user][:website], age: params[:user][:age], school: params[:user][:school]})
            end
            redirect_to users_profile_path
        end
end
