class Team < ApplicationRecord
    has_many :team_users
    has_many :user, through: :team_users
    
    has_many :solves
    
    has_many :partecipate
    has_many :ctf, through: :partecipate
end
