require 'rails_helper'

RSpec.describe UsersController do
  before do
    @alpha = User.create!(username: 'alpha', token: 'asdf1234', uid: '12345678')
    @beta = User.create!(username: 'beta', token: 'hhhh893', uid: '87765431')
    @gamma = User.create!(username: 'gamma', token: 'yuio9909', uid: '657483920')
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @alpha.id, info: 'lots of stuff', archived: false, plays: 90, score: 150 )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @alpha.id, info: 'lots of stuff', archived: false, plays: 5, score: 125 )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @beta.id, info: 'lots of stuff', archived: false, plays: 100, score: 300 )
  end

  describe '#current_user' do
    describe 'when given a correct user token' do
      it 'finds the current user' do
        expect(User.find_by(token: 'asdf1234')).to eq @alpha
      end
    end

    describe 'when given an incorrect user token' do
      it 'raises a record invalid error' do
        expect( User.find_by(token: 'fdsa23489') ).to eq nil
      end
    end
  end

  describe '#update_current_play' do
    describe 'when given correct params' do
      it 'finds the current user' do
        expect(User.find_by(token: 'asdf1234')).to eq @alpha
      end

      it 'updates the playing game user attribute' do
        @user = User.find_by(token: 'asdf1234')
        @user.playing_game = @g3.id
        @user.save!
        expect( @user.playing_game ).to eq( @g3.id )
      end
    end

    describe 'when given an incorrect user token' do
      it 'raises a record invalid error' do
        expect( User.find_by(token: 'fdsa23489') ).to eq nil
      end
    end
  end

  describe '#update_current_edit' do
    describe 'given valid game params' do
      it 'returns a game based on id' do
        expect( Game.find(@g1.id) ).to eq( @g1 )
      end

      it 'finds the current user' do
        expect(User.find_by(token: 'asdf1234')).to eq @alpha
      end

      it 'updates the user editing game attribute' do
        @user = User.find_by(token: 'asdf1234')
        @user.editing_game = @g3.id
        @user.save!
        expect( @user.editing_game ).to eq( @g3.id )
      end
    end

    describe 'given invalid game params' do
      it 'raises a record invalid error' do
        expect{ Game.find(12345) }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end
  end

  describe '#find_current_game_send_response' do
    before do
      @user = User.find_by(token: 'asdf1234')
      @user.playing_game = @g2.id
      @user.editing_game = @g3.id
      @user.save!
    end

    it 'finds a game by the given param, either the user playing or editing game attribute' do
      expect( Game.find_by(id: @user.playing_game) ).to eq( @g2 )
      expect( Game.find_by(id: @user.editing_game) ).to eq( @g3 )
    end
  end

  describe '#current_username' do
    it 'returns the username of the current user' do
      @current_user = User.find_by(token: 'asdf1234')
      expect( @current_user.username ).to eq( 'alpha' )
    end
  end

  describe '#update' do
    it 'finds the user by id' do
      expect( User.find(@beta.id) ).to eq @beta
    end

    describe 'when username is unique' do
      it 'reassigns the username of the user' do
        @user = User.find( @beta.id )
        @user.username = 'delta'
        @user.save!
        expect( @user.username ).to eq( 'delta' )
      end
    end

    describe 'when username is not unique' do
      it 'returns an invalid response error' do
        @user = User.find( @beta.id )
        expect{
          @user.username = 'alpha'
          @user.save!
        }.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end
end
