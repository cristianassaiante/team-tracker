class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable, :confirmable
    
    has_many :team_users
    has_many :team, through: :team_users
    
    has_many :chal, through: :solves
    has_many :solves
end
