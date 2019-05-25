class Chal < ApplicationRecord
    belongs_to :ctf
    has_many :solve
end
