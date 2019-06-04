class HomeController < ApplicationController
    
    $twitter_client = Twitter::REST::Client.new do | config |
        config.consumer_key = Rails.application.secrets.twitter_api_key
        config.consumer_secret = Rails.application.secrets.twitter_secret_key
    end
    
    def index
        if current_user.present? && current_user.team_id
            redirect_to team_home_path
        else
            @tweets = []
            @tweets += $twitter_client.search("#ctf", result_type: "recent", lang: "en").first(2)
            @tweets += $twitter_client.search("#defcon", result_type: "recent", lang: "en").first(3)
            @minimum_password_length = 8
        end
    end
    
    def flag
        flash[:flag] = "TT{d1d_u_kn0w_th4t_mhackeroni_r_g01n9_2_V3945?!?}"
        redirect_to home_path
    end
end
