class Ctf < ApplicationRecord
    has_many :chal
    
    has_many :partecipate
    has_many :team, through: :partecipate
end
