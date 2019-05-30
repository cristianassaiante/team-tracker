class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    
    def ban
        @to_ban = params[:id_to_ban]
        @user = User.find_by(id: @to_ban)
        @user.update_attribute(:team_id, nil)
        
        redirect_to teamhome_path
    end
end
