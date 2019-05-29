class TeamHomeController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    
    def index
    end
    
    def create
        @team = Team.new
        @team.name = params[:teamname]
        
        if Team.find_by(name: params[:teamname])
            flash[:create_error] = "Team name already exists"
            redirect_to home_path
        else
            @team.save
            current_user.update_attribute(:team_id, @team.id)
            current_user.update_attribute(:is_admin, true)
            
            redirect_to teamhome_path
        end
    end
    
    def join
        @team = Team.find_by(token: params[:teamtoken])
        if @team
            current_user.update_attribute(:team_id, @team.id)
            redirect_to teamhome_path
        end
    end
end
