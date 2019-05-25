class User < ApplicationRecord
    has_and_belongs_to_many :team
    has_many :solve
end
