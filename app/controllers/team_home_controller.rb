class TeamHomeController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    require 'open-uri'
    
    def index
        if !current_user.team_id
            flash[:create_error] = "You have to create a team before access the team home"
            flash[:join_error] = "You have to join a team before access the team home"
            redirect_to home_path
        else
            @team = Team.find_by(id: current_user.team_id)
            @team_users = User.where(team_id: @team.id)
            
            @epoch = Time.now.to_i
            @start = @epoch - 2592000
            @ctfs = Ctf.all.order("id desc").limit(5)
            
            if @ctfs.length == 0
              @url = "https://ctftime.org/api/v1/events/?limit=100&start=%d&finish=%d" % [@start, @epoch]
              @response = JSON.load(open(@url).read)
              @len = @response.length
              for offset in 0..@len-1
                  Ctf.where(name: @response[offset]['title'])
                      .first_or_create(name: @response[offset]['title'], onsite: @response[offset]['onsite'], location: @response[offset]['location'])
              end
              @ctfs = Ctf.all.order("id desc").limit(5)
            end
            
            if current_user.is_admin
                @challenges = ActiveRecord::Base.connection.execute("select chals.name as chal_name, chals.points as chal_points, ctfs.name as ctf_name, users.username as username, chals.id as chal_id from chals, solves,ctfs,users where solves.team_id = %d and solves.chal_id = chals.id and solves.is_pending = true and ctfs.id = chals.ctf_id and users.id = solves.user_id" % [@team.id]).as_json
            end
        end
    end
    
    def notifications
        @chal_id = params[:chal_id]
        @action = params[:accept] != nil
        @solve = Solve.where(chal_id: @chal_id, team_id: current_user.team_id)
        p @solve
        @solve = @solve[0]
        if @action
           @solve.update_attribute(:is_pending, false)
        else
           @solve.destroy
        end
        redirect_to team_home_path
    end
    
    def maps
        @ctf = Ctf.find_by(id: params[:ctf_id])
        
        @url = "https://dev.virtualearth.net/REST/v1/Locations?q=%s&key=%s" % [@ctf.location, Rails.application.secrets.bing_api_key]
        @response = JSON.load(open(@url).read) 
        @coordinates = @response["resourceSets"][0]["resources"][0]["point"]["coordinates"]
        
        @coordinates = "%s~%s" % [@coordinates[0], @coordinates[1]]
        flash[:maps_path] = "https://www.bing.com/maps/embed?h=500&w=400&cp=%s&lvl=8&typ=d&sty=r&src=SHELL&FORM=MBEDV8" % [@coordinates]
        redirect_to team_home_path
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
            
            redirect_to team_home_path
        end
    end
    
    def new_token 
        if current_user.is_admin
           @token = SecureRandom.random_bytes(16)
           @hashed_token = Digest::SHA256.hexdigest(@token)
           @team = Team.find_by(id: current_user.team_id)
           
           @team.update_attribute(:token, @hashed_token)
           flash[:token_info] = @token.unpack("H*")[0]
           redirect_to team_home_path
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
            redirect_to team_home_path
        else
            flash[:join_error] = "Invalid token"
            redirect_to home_path 
        end
    end
    
    def ban
        @to_ban = params[:id_to_ban]
        @user = User.find_by(id: @to_ban)
        @user.update_attribute(:team_id, nil)
        
        redirect_to team_home_path
    end

    def update
        if params[:team][:name].blank?
            flash[:team_name_blank_error] = "Team name cannot be blank"
            redirect_to team_edit_path
            return
        end

        @cose = Team.find_by(name: params[:team][:name])
        if !@cose.nil? && @cose.id != current_user.team_id
            flash[:team_name_exist_error] = "Team name alredy exists"
            redirect_to team_edit_path
            return
        end

        @team = Team.find_by(id: current_user.team_id)
        @team.update_attributes(name: params[:team][:name], need_chal_confirmation: params[:team][:need_chal_confirmation])
        redirect_to team_edit_path
    end
end
