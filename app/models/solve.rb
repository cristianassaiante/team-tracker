class Solve < ApplicationRecord
    belongs_to :user
    belongs_to :chal
    belongs_to :team
end
