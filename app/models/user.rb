class User < ApplicationRecord
    has_many :team_users
    has_many :team, through: :team_users
    
    has_many :chal, through: :solves
    has_many :solves
end
