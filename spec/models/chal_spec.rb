require "rails_helper"

describe Chal, :type => :model do

    it "Create Chal" do
        session = Chal.new(:name => "ChalName", :ctf_id => 0, :points => 123, :categ => "Reverse")
        expect(session).to be_valid
    end
    
    it "is not valid without a ctf" do
        session = Chal.new(:name => "ChalName", :ctf_id => nil, :points => 123, :categ => "Reverse")
        expect(session).to_not be_valid
    end
    
    it "is not valid without a name" do
        session = Chal.new(:name => nil, :ctf_id => 0, :points => 123, :categ => "Reverse")
        expect(session).to_not be_valid
    end
    
    it "is not valid without a category" do
        session = Chal.new(:name => "ChalName", :ctf_id => 0, :points => 123, :categ => nil)
        expect(session).to_not be_valid
    end
    
    it "is not valid without points value" do
        session = Chal.new(:name => "ChalName", :ctf_id => 0, :points => nil, :categ => "Reverse")
        expect(session).to_not be_valid
    end
end
