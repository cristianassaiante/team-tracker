class UserStatController < ApplicationController


    def index
        if !current_user.team_id
            flash[:create_error] = "You have to create a team before access the team home"
            flash[:join_error] = "You have to join a team before access the team home"
            redirect_to home_path
            return
        end
        @team_id = current_user.team_id
        @user_id = current_user.id
        @team = Team.find_by(id: current_user.team_id)
        @query = ActiveRecord::Base.connection.execute("select chals.name as chal_name, chals.categ as chal_cat, chals.points as chal_points from solves, users, chals where solves.chal_id = chals.id and solves.is_pending = false and  users.id = solves.user_id and users.id = %d" % [@user_id]).as_json
        @user_stat = [0,0,0,0,0]
        @total = 0
        @user_chal = []
        
        @query.each do |chal|
            @user_chal.push({name: chal["chal_name"], points: chal["chal_points"]})
            case chal["chal_cat"]
                when "Reverse"
                    @user_stat[0] += 1
                    @total += chal["chal_points"].to_i
                when "Pwn" 
                    @user_stat[1] += 1
                    @total += chal["chal_points"].to_i
                when "Misc" 
                    @user_stat[2] += 1
                    @total += chal["chal_points"].to_i
                when "Crypto" 
                    @user_stat[3] += 1
                    @total += chal["chal_points"].to_i
                when "Web" 
                    @user_stat[4] += 1
                    @total += chal["chal_points"].to_i
            end
        end
       
    end

end
