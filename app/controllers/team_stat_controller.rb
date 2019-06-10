class TeamStatController < ApplicationController
    
    
    def index
        if !current_user.team_id
            flash[:create_error] = "You have to create a team before access the team home"
            flash[:join_error] = "You have to join a team before access the team home"
            redirect_to home_path
            return
        end
        @team = Team.find_by(id: current_user.team_id)
        @query = ActiveRecord::Base.connection.execute("select chals.name as chal_name, chals.categ as chal_cat, chals.points as chal_points, users.username as username, ctfs.name as ctf_name from solves, chals, users, ctfs where solves.team_id = %d and solves.chal_id = chals.id and solves.is_pending = false and users.id = solves.user_id and ctfs.id = chals.ctf_id" % [@team.id]).as_json
        @user_stat = [0,0,0,0,0]
        @user_chal = []
        @total = 0
        @query.each do |chal|
           @user_chal.push({name: chal["chal_name"], points: chal["chal_points"], category: chal["chal_cat"], username: chal["username"], ctf_name: chal["ctf_name"]})
           case chal["chal_cat"]
              when "Reverse"
                  @user_stat[0] += chal["chal_points"].to_i
              when "Pwn" 
                  @user_stat[1] += chal["chal_points"].to_i
              when "Misc" 
                  @user_stat[2] += chal["chal_points"].to_i
              when "Crypto" 
                  @user_stat[3] += chal["chal_points"].to_i
              when "Web" 
                  @user_stat[4] += chal["chal_points"].to_i
           end
        end
       @total = @user_stat.sum
    end
end
