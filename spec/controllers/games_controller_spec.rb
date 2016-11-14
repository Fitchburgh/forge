require 'rails_helper'

RSpec.describe GamesController do
  let(:name) { 'Shark' }

  # describe "#index" do
  #   it "returns http success" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#create" do
    describe 'with correct params' do
      it 'creates a new game' do
        expect{ Game.create(name: name) }.to change{ Game.count }.by(1)
      end
    end

    describe 'with incorrect params' do
      it 'does not create a new game' do
        expect{ Game.create(description: 'Harry Potter rpg') }.to change{ Game.count }
      end

      it 'does not create a new game given no name' do
        expect{ Game.create(name: nil) }.to change{ Game.count }
      end
    end
  end

  # describe "#update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#delete" do
    it 'deletes a game' do
      expect{ Game.delete(name: name) }.to change{ Game.count }.by(-1)
    end
  end

  # describe "#play" do
  #   it "returns http success" do
  #     get :play
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "#search" do
  #   it "returns http success" do
  #     get :search
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "#savegame" do
  #   it "returns http success" do
  #     get :savegame
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
