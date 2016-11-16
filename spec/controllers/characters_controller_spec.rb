require 'rails_helper'

RSpec.describe CharactersController, type: :controller do

  # describe "GET #search" do
  #   it "returns http success" do
  #     get :search
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #create" do
    before do
      @user = User.create!(username: 'dude', uid: '256807', token: '89jfa8j4983aj')
      @character = Character.create!(name: 'Manbearpig', user_id: @user.id, current: true, obj: "{json stuff}")
    end
    it "returns a new character was created successfully" do
      get :create
      expect{ Character.create!(name: name, user_id: @user.id, current: current, obj: obj) }.to change{ Character.count }.by(1)
    end
  end

  # describe "GET #delete" do
  #   it "returns http success" do
  #     get :delete
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
