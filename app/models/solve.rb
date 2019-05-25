class Solve < ApplicationRecord
    belongs_to :user
    belongs_to :chat
    belongs_to :team
end
