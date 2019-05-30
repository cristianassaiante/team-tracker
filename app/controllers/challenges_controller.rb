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
       @x.push(@response[@len - 1 - offset]['title'])
       Ctf.where(name: @response[@len - 1 - offset]['title'])
               .first_or_create(name: @response[@len - 1 - offset]['title'], onsite: @response[@len - 1 - offset]['onsite'], location: @response[@len - 1 - offset]['location'])
   end
   @ctfs = @x
   @team = Team.find_by(id: current_user.team_id)
end

def create
   @ctfname = params[:ctf_name]
   @points = params[:points].to_i
   @cat = params[:category]
   @chall_name = params[:chall_name]
   @ctf_id = Ctf.find_by(name: @ctfname).id
   @chal = Chal.where(name: @chall_name, ctf_id: @ctf_id)
               .first_or_create(name: @chall_name, ctf_id: @ctf_id, points: @points, categ: @cat)
   
   @solve = Solve.new
   @solve.is_pending = ! current_user.is_admin
   @solve.team_id = current_user.team_id
   @solve.user_id = current_user.id
   @solve.chal_id = @chal.id
   @solve.save
   
   redirect_to teamhome_path
end
    

end
