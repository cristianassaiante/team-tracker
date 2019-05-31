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
end
