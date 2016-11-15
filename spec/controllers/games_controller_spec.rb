require 'rails_helper'
require 'pry'

RSpec.describe GamesController do
  before do
    @user = User.create!(username: 'dude', uid: '256807', token: '89jfa8j4983aj')
    @game = Game.create!(name: 'aarg', tags: '["pirate", "action"]', user_id: @user.id, obj: '{"gre": "qqqq", {"ooo": "pppp"}}')
  end

  let(:name) { 'Shark' }

  describe "#create" do
    describe 'with correct params' do
      it 'creates a new game' do
        expect{ Game.create!(name: name, user_id: @user.id) }.to change{ Game.count }.by(1)
      end
    end

    describe 'with incorrect params' do
      it 'does not create a new game' do
        expect{ Game.create!(description: 'Harry Potter rpg', user_id: @user.id) }.to raise_error{ ActiveRecord::RecordInvalid }
      end

      it 'does not create a new game given no name' do
        expect{ Game.create!(name: nil, user_id: @user.id) }.to raise_error{ ActiveRecord::RecordInvalid }
      end
    end
  end

  # describe "#update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "#delete" do
  #   it 'deletes a game' do
  #     expect{ Game.delete(name: name) }.to change{ Game.count }.by(-1)
  #   end
  # end

  # describe "#play" do
  #   it "returns http success" do
  #     get :play
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "#search" do
    it "returns an array of games who's tags or game name include the params" do
      Game.create!(name: 'war game', user_id: @user.id, tags: '["battle", "fighting", "strategy"]')
      Game.create!(name: 'pirate matey', user_id: @user.id, tags: '["pirates", "war", "rpg"]')
      Game.create!(name: 'legend of zelda', user_id: @user.id, tags: '["rpg", "adventure"]')
      Game.create!(name: 'game of life', user_id: @user.id, tags: '["strategy", "blob game"]')

      @games = []
      Game.all.each do |t|
        @games << t.name if t.tags.include?('war') || t.name.include?('war')
      end

      expect(@games.count).to eq 2
    end
  end

  describe "#savegame" do
    it "returns the json object saved upon success of saving game" do
      expect(@save = SaveGame.create!(game_id: @game.id, user_id: @user.id, obj: '{"as": "fajois", {"fs": "{"r": "ppp"}"}}')).to eq @save
    end
  end
end
