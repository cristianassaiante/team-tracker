class Chal < ApplicationRecord
    belongs_to :ctf, optional: true
    has_many :user, through: :solves

    validates :name, 
              presence: true

    validates :ctf_id,
              presence: true

    validates :points, 
              presence: true

    validates :categ,
              presence: true
end
