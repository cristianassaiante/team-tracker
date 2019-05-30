class TeamHomeController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    
    def index
        if !current_user.team_id
            flash[:create_error] = "You have to create a team before access the team home"
            flash[:join_error] = "You have to join a team before access the team home"
            redirect_to home_path
        else
            @team = Team.find_by(id: current_user.team_id)
        end
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
    
    def new_token 
        if current_user.is_admin
           @token = SecureRandom.random_bytes(16)
           @hashed_token = Digest::SHA256.hexdigest(@token)
           @team = Team.find_by(id: current_user.team_id)
           
           @team.update_attribute(:token, @hashed_token)
           flash[:token_info] = @token.unpack("H*")[0]
           redirect_to teamhome_path
        else
           flash[:token_i] = "Unauthorized" 
        end
    end
    
    def join
        @plain_token = [params[:teamtoken]].pack("H*")
        @token = Digest::SHA256.hexdigest(@plain_token)
        @team = Team.find_by(token: @token)
        if @team
            current_user.update_attribute(:team_id, @team.id)
            redirect_to teamhome_path
        else
            flash[:join_error] = "Invalid token"
            redirect_to home_path 
        end
    end
end
