require 'rails_helper'

RSpec.describe PreloginUsersController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff', archived: false, published: true, plays: 90, score: 150 )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff', archived: false, published: true, plays: 5, score: 125 )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff', archived: false, published: true, plays: 100, score: 300 )
    @g4 = Game.create!( name: 'rock paper scissors', tags: 'hand gesture game', description: 'you win 1/3 of the time, usually', user_id: @u2.id, info: 'lots of stuff', archived: false, published: true, plays: 200, score: 100 )
    @g5 = Game.create!( name: 'samurai slice', tags: 'fighting, rpg, sword fighting', description: 'none', user_id: @u1.id, info: 'lots of stuff', archived: false, published: true, plays: 5, score: 150 )
    @g6 = Game.create!( name: 'sailor jerry', tags: 'action, rpg, adventure', description: 'imagine popeye constantly on spinnach', user_id: @u2.id, info: 'lots of stuff', archived: true, published: true, plays: 250, score: 200 )
  end

  describe '#index' do
    describe 'given correct params' do
      it 'returns all games that are published and have not been archived' do
        expect( Game.where("archived = ? AND published = ?", false, true).count ).to eq( 5 )
      end
    end
  end

  describe '#load' do
    it 'returns a game by name' do
      expect( Game.find_by(name: 'neature') ).to eq( @g1 )
      expect( Game.find_by(name: 'kreature kombat') ).to eq( @g2 )
      expect( Game.find_by(name: 'asdf') ).to eq( nil )
    end
  end

  describe '#create' do
    describe 'given the correct params' do
      it 'creates a new user' do
        expect{ User.create!(
          username: 'winky',
          token: 'asdf32455jkkkkkkkh5234',
          uid: 6574839201,
          google_oauth_data: 'google info'
        )}.to change{ User.count }.by(1)
      end
    end

    describe 'given incorrect params' do
      it 'raises an error when the username param not given' do
        expect{ User.create!(
          token: 'asdf32455jkkkkkkkh5234',
          uid: 6574839201,
          google_oauth_data: 'google info'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an error when the token param not given' do
        expect{ User.create!(
          username: 'winky',
          uid: 6574839201,
          google_oauth_data: 'google info'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an error when the uid param not given' do
        expect{ User.create!(
          username: 'winky',
          token: 'asdf32455jkkkkkkkh5234',
          google_oauth_data: 'google info'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe '#login' do
    it 'finds a user by their uid' do
      expect( User.find_by(uid: 238879432983) ).to eq( @u1 )
      expect( User.find_by(uid: 34123432123) ).to eq( @u2 )
    end

    it 'reassigns the value of a user\'s token' do
      @user = User.find_by(uid: 238879432983)
      @user.token = 8675309
      @user.save!
      expect( @user.token ).to eq( '8675309' )
    end
  end

  describe '#count' do
    it 'returns a game by id' do
      expect( Game.find( @g1.id ) ).to eq( @g1 )
    end

    it 'increments the plays of a game by one' do
      @game = Game.find( @g1.id )
      @game.increment!(:plays)
      @game.save!
      expect( @game.plays ).to eq( 91 )
    end
  end

  describe '#search' do
    describe 'given correct params' do
      it 'returns all games that are published and have not been archived' do
        expect( Game.where("archived = ? AND published = ?", false, true).count ).to eq( 5 )
      end

      it 'returns all of these games where the name or tags include user input' do
        @games = Game.where("archived = ? AND published = ?", false, true)
        result = []
        @games.each do |game|
          result << game if game.tags.include?('rpg') || game.name.include?('rpg')
        end
        expect( result.count ).to eq( 1 )
        expect( result.first ).to eq( @g5 )
      end
    end
  end
end
