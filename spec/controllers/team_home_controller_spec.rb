require 'rails_helper'

describe TeamHomeController, type: :controller do
  before :each do
    @team = FactoryBot.create(:team)
    @user2 = FactoryBot.create(:user, team_id: @team.id, is_admin: true)
    @user3 = FactoryBot.create(:user2, team_id: @team.id, is_admin: false)
    sign_in @user2
  end

  describe "GET team home" do
    it 'should returns a 200 status code' do
      get 'index'
      expect(response.status).to eq(200)
    end

    it 'should render the index page' do
      get 'index'
      expect(response).to render_template('index')
    end
  end

  describe "POST new team token" do

    it 'should return a 302 status code' do
      post :new_token
      expect(response.status).to eq(302) #redirect status code
    end

    it 'should redirect to team home page' do
      post :new_token
      expect(response).to redirect_to(team_home_path)
    end

    it 'should show new team token' do
      post :new_token
      expect(flash[:token_info]).to be_present
    end

  end

  describe "POST banhammer" do

    it 'should return a 302 status code' do
      post :ban, params: {id_to_ban: @user2.id}
      expect(response.status).to eq(302) #redirect status code
    end

    it 'should redirect to team home page' do
      post :ban, params: {id_to_ban: @user2.id}
      expect(response).to redirect_to(team_home_path)
    end

    it 'should remove team_id from user table' do
      post :ban, params: {id_to_ban: @user2.id}
      @user2.reload
      expect(@user2.team_id).to be_nil
    end
  end

  describe "POST show map", on_site: true do

    it 'should return 302 status code' do
      post :maps, params: {ctf_id: @ctf.id}
      expect(response.status).to eq(302) #redirect status code
    end

    it 'should redirect to team home page' do
      post :maps, params: {ctf_id: @ctf.id}
      expect(response).to redirect_to(team_home_path)
    end

    it 'should show the location on the map' do
      post :maps, params: {ctf_id: @ctf.id}
      expect(flash[:maps_path]).to be_present
    end
  end

  describe "PUT update team name" do

    it 'should return 302 status code' do
      put :update, params: {team: {name: @team.name}}
      expect(response.status).to eq(302) #redirect status code
    end

    it 'should redirect to settings page' do
      put :update, params: {team: {name: @team.name}}
      expect(response).to redirect_to(team_edit_path)
    end
  end



end
