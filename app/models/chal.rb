class Chal < ApplicationRecord
    belongs_to :ctf, optional: true
    has_many :user, through: :solves
end
