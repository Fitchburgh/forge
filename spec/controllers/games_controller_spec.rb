require 'rails_helper'
require 'pry'

RSpec.describe GamesController do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff' )
  end

  describe "#create" do
    describe 'with correct params' do
      it 'creates a new game' do
        expect{ Game.create!(name: 'shark', user_id: @u1.id) }.to change{ Game.count }.by(1)
        expect( Game.find(@g1.id) ).to eq @g1
      end
    end

    describe 'with incorrect params' do
      it 'raises an invalid record error if user does not exist' do
        expect{ Game.create!(
          name: 'milky way',
          tags: 'adventure',
          description: 'candy bar or space adventure, you decide',
          user_id: 1234,
          info: 'stuffy stuff stuff',
        )}.to raise_error{ ActiveRecord::RecordInvalid }
      end

      it 'raises an invalid record error if name param not given' do
        expect{ Game.create!(
          tags: 'adventure',
          description: 'candy bar or space adventure, you decide',
          user_id: @u1.id,
          info: 'stuffy stuff stuff',
        )}.to raise_error{ ActiveRecord::RecordInvalid }
      end

      it 'raises an invalid record error if tags param not given' do
        expect{ Game.create!(
          name: 'milky way',
          description: 'candy bar or space adventure, you decide',
          user_id: 1234,
          info: 'stuffy stuff stuff',
        )}.to raise_error{ ActiveRecord::RecordInvalid }
      end

      it 'raises an invalid record error if description param not given' do
        expect{ Game.create!(
          name: 'milky way',
          tags: 'adventure',
          user_id: 1234,
          info: 'stuffy stuff stuff',
        )}.to raise_error{ ActiveRecord::RecordInvalid }
      end

      it 'raises an invalid record error if user id param not given' do
        expect{ Game.create!(
          name: 'milky way',
          tags: 'adventure',
          description: 'candy bar or space adventure, you decide',
          info: 'stuffy stuff stuff',
        )}.to raise_error{ ActiveRecord::RecordInvalid }
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
      Game.create!(name: 'war game', user_id: @u1.id, tags: '["battle", "fighting", "strategy"]')
      Game.create!(name: 'pirate matey', user_id: @u1.id, tags: '["pirates", "war", "rpg"]')
      Game.create!(name: 'legend of zelda', user_id: @u1.id, tags: '["rpg", "adventure"]')
      Game.create!(name: 'game of life', user_id: @u1.id, tags: '["strategy", "blob game"]')

      @games = []
      Game.all.each do |t|
        @games << t.name if t.tags.include?('war') || t.name.include?('war')
      end
      expect(@games.count).to eq 2
    end
  end

  describe "#savegame" do
    it "returns the json object saved upon success of saving game" do
      expect(@save = SaveGame.create!(game_id: @g1.id, user_id: @u1.id, info: 'random info')).to eq @save
    end
  end
end
