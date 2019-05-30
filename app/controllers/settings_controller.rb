class SettingsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @team = Team.find_by(id: current_user.team_id)
    end
end
