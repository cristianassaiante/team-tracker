class ChallengesController < ApplicationController
require 'open-uri'
skip_before_action :verify_authenticity_token
before_action :authenticate_user!
def index
   @epoch = Time.now.to_i
   @start = @epoch - 2592000
   @url = "https://ctftime.org/api/v1/events/?limit=100&start=%d&finish=%d" % [@start, @epoch]
   @response = JSON.load(open(@url).read)
   @x = []
   @len = @response.length
   for offset in 0..@len-1
       @x.push(@response[offset]['title'])
       Ctf.where(name: @response[offset]['title'])
               .first_or_create(name: @response[offset]['title'], onsite: @response[offset]['onsite'], location: @response[offset]['location'])
   end
   @ctfs = @x
   @team = Team.find_by(id: current_user.team_id)
end

def create

   if params[:points].blank?
      flash[:blank_points_error] = "Points cannot be blank"
      redirect_to challenges_path
      return
   end

   if params[:chall_name].blank?
      flash[:blank_chall_name_error] = "Challege name cannot be blank"
      redirect_to challenges_path
      return
   end

   if !params[:points].is_a? Integer
      flash[:not_int_points_error] = "Points must be integer"
      redirect_to challenges_path
      return
   end
   @ctfname = params[:ctf_name]
   @points = params[:points].to_i
   @cat = params[:category]
   @chall_name = params[:chall_name]
   @ctf_id = Ctf.find_by(name: @ctfname).id
   @chal = Chal.where(name: @chall_name, ctf_id: @ctf_id)
               .first_or_create(name: @chall_name, ctf_id: @ctf_id, points: @points, categ: @cat)
   
   @solve = Solve.new
   @solve.is_pending = !(current_user.is_admin || !Team.find_by(id: current_user.team_id).need_chal_confirmation)
   @solve.team_id = current_user.team_id
   @solve.user_id = current_user.id
   @solve.chal_id = @chal.id
   @solve.save
   
   redirect_to team_home_path
end
    

end
