require "rails_helper"

describe Team, :type => :model do

    it "Create Team" do
        session = Team.new(:name => "TeamName1")
        expect(session).to be_valid
    end
    
    it "is not valid without a name" do
        session = Team.new(:name => nil)
        expect(session).to_not be_valid
    end
end
