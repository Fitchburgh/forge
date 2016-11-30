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
    # game = params[:game_id]
    # current_user
    # @user.editing_game = game
    # if @user.save
    #   render json: 'User updated'
    # describe 'given valid game params' do
    #   it 'returns a game based on id' do
    #     expect( Game.find(@g1.id) ).to eq( @g1 )
    #   end
    #
    #   it 'finds the current user' do
    #     expect(User.find_by(token: 'asdf1234')).to eq @alpha
    #   end
    #
    #   it ''
    # end

    describe 'given invalid game params' do
      it 'raises a record invalid error' do
        expect( Game.find(12345) ).to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end
end
