require 'rails_helper'

describe ProfileController, type: :controller do
  before :each do
    @team = FactoryBot.create(:team)
    @user1 = FactoryBot.create(:user, team_id: @team.id)
    sign_in @user1
  end

  describe "GET profile" do
    it 'should returns a 200 status code' do
      get 'index'
      expect(response.status).to eq(200)
    end

    it 'should render the index page' do
      get 'index'
      expect(response).to render_template('index')
    end

  end

  describe 'PUT profile' do

    it 'should render the profile form' do
      get 'index'
      expect(response).to render_template('index')
    end
  end

  it 'should update the user correctly' do
    put :update, params: {user: {username: @user1.username+"_updated",
                                 website: 'test.com', age: '22',
                                 nationality: 'Italy', school: 'PhD'}}

    expect(response).to redirect_to("/users/profile")
  end

end

