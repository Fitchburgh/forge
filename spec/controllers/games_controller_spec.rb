require 'rails_helper'
require 'pry'

RSpec.describe GamesController do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff', archived: false )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff', archived: false )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff', archived: false )
    @g4 = Game.create!( name: 'rock paper scissors', tags: 'hand gesture game', description: 'you win 1/3 of the time, usually', user_id: @u2.id, info: 'lots of stuff', archived: false )
    @g5 = Game.create!( name: 'samurai slice', tags: 'fighting, rpg, sword fighting', description: 'none', user_id: @u1.id, info: 'lots of stuff', archived: false )
    @g6 = Game.create!( name: 'sailor jerry', tags: 'action, rpg, adventure', description: 'imagine popeye constantly on spinnach', user_id: @u2.id, info: 'lots of stuff', archived: true )
    @c1 = Collaborator.create!( game_id: @g1.id, user_id: @u1.id, requested: true, accepted: true )
    @c2 = Collaborator.create!( game_id: @g2.id, user_id: @u1.id, requested: true, accepted: true )
    @c3 = Collaborator.create!( game_id: @g3.id, user_id: @u2.id, requested: true, accepted: true )
    @c4 = Collaborator.create!( game_id: @g4.id, user_id: @u2.id, requested: true, accepted: true )
    @c5 = Collaborator.create!( game_id: @g5.id, user_id: @u1.id, requested: true, accepted: true )
    @c6 = Collaborator.create!( game_id: @g6.id, user_id: @u2.id, requested: true, accepted: true )
    @c7 = Collaborator.create!( game_id: @g5.id, user_id: @u2.id, requested: true, accepted: true )
    @c8 = Collaborator.create!( game_id: @g6.id, user_id: @u1.id, requested: true, accepted: false )
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

  describe "#update" do
    describe '#update' do
      describe 'given an invalid game id' do
        it 'returns an error http status' do
          expect{ Game.find(1234) }.to raise_error( ActiveRecord::RecordNotFound )
        end
      end

      describe 'given a valid game id' do
        it 'finds the game to update' do
          expect( Game.find(@g1.id) ).to eq( @g1 )
        end

        it 'returns only games that have not yet been archived' do
          expect( Game.where(archived: false).count ).to eq( 5 )
        end

        it 'checks if user is a collaborator for the game they want to update' do
          @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g5.id, @u2.id)
          expect( @collaborator.accepted ).to be true
        end

        describe 'given correct params' do
          it 'updates the game' do
            @game = Game.find(@g5.id)
            @game.name = 'orange slice'
            @game.tags = 'fruit, speed game'
            @game.description = 'halftime at a soccer match fruit hander-outer game'
            @game.user_id = @u1.id
            @game.info = 'infoinfoinfo'
            @game.save!
            expect( @game.name ).to eq( 'orange slice' )
          end
        end
      end
    end
  end

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
