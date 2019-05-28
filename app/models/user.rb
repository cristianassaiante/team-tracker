class User < ApplicationRecord

    PASSWORD_FORMAT = /\A
        (?=.{8,})          # 8+ char (ridondante, c'è un home_controller)
        (?=.*\d)           # digit
        (?=.*[a-z])        # minuscolo
        (?=.*[A-Z])        # maiuscolo
        /x
        
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable, :confirmable, omniauth_providers: [:github]
    
    validates :password, 
        presence: true, 
        length: {in: 6..40}, 
        format: { with: PASSWORD_FORMAT }, 
        confirmation: true, 
        on: :create 

    validates :password, 
        length: { in: 6..40}, 
        format: { with: PASSWORD_FORMAT }, 
        confirmation: true, 
        on: :update
    
      validates :email, 
        presence: true, 
        format: { with: Devise::email_regexp }, 
        on: :create 

    validates :email, 
        presence: true, 
        format: { with: Devise::email_regexp }, 
        on: :update
    
    has_many :team_users
    has_many :team, through: :team_users
    
    has_many :chal, through: :solves
    has_many :solves
end
