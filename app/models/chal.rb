class Chal < ApplicationRecord
    belongs_to :ctf
    has_many :user, through: :solves
end
