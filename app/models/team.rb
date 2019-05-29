class Team < ApplicationRecord
    has_many :solves
    
    has_many :partecipate
    has_many :ctf, through: :partecipate
end
