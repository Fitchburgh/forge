require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @u3 = User.create!(username: 'wolverine', token: 'asdfJKLxcNBV', uid: 99988766544, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff', published: true, archived: false, score: 100, plays: 12, thumbnail: 'asdf' )
    @g2 = Game.create!( name: 'navy vs navy', tags: 'boats, game', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff', published: true, archived: false, score: 150, plays: 123, thumbnail: 'asdf' )
    @g3 = Game.create!( name: 'maze walker', tags: 'puzzle, maze', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff', published: true, archived: false, score: 100, plays: 2, thumbnail: 'asdf' )
    @c1 = Collaborator.create!( game_id: @g1.id, user_id: @u1.id, requested: true, accepted: true )
    @c2 = Collaborator.create!( game_id: @g1.id, user_id: @u2.id, requested: false, accepted: false )
    @c3 = Collaborator.create!( game_id: @g2.id, user_id: @u1.id, requested: true, accepted: true )
    @c4 = Collaborator.create!( game_id: @g2.id, user_id: @u3.id, requested: true, accepted: true )
    @c5 = Collaborator.create!( game_id: @g2.id, user_id: @u2.id, requested: true, accepted: false )
    @c6 = Collaborator.create!( game_id: @g3.id, user_id: @u2.id, requested: true, accepted: true )
    @c7 = Collaborator.create!( game_id: @g3.id, user_id: @u1.id, requested: true, accepted: true )
  end

  describe '#check_collab_existence' do
    describe 'given a valid game id and user id' do
      it 'finds a collaborator for a game by their user id' do
        @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id)
        expect( @collaborator ).to eq( @c2 )
      end
    end

    describe 'given an incorrect game id or user id' do
      it 'returns collaborator as nil' do
        @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u3.id)
        expect( @collaborator ).to be nil
      end

      it 'returns collaborator as nil' do
        @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g3.id, @u3.id)
        expect( @collaborator ).to be nil
      end
    end

    describe 'given an invalid game id or user id' do
      it 'returns an error for trying to call id on nil' do
        expect{ Collaborator.find_by('game_id = ? AND user_id = ?', @g5.id, @u1.id) }.to raise_error( NoMethodError )
      end

      it 'returns an error for trying to call id on nil' do
        expect{ Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u8.id) }.to raise_error( NoMethodError )
      end
    end
  end

  describe '#create' do
    describe 'given correct params' do
      it 'finds the newly created collaborator' do
        expect( Collaborator.find(@c1.id) ).to eq @c1
      end
    end

    describe 'given incorrect params' do
      it 'raises an invalid record error if game id does not exist' do
        expect{ Collaborator.create!(
          user_id: @u2.id,
          requested: true,
          accepted: false
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game id is not an integer' do
        expect{ Collaborator.create!(
          game_id: 'id',
          user_id: @u2.id,
          requested: true,
          accepted: false
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user id does not exist' do
        expect{ Collaborator.create!(
          game_id: @g1.id,
          requested: true,
          accepted: false
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user id is not an integer' do
        expect{ Collaborator.create!(
          game_id: @g1.id,
          user_id: 'id',
          requested: true,
          accepted: false
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe '#make_user_collaborator_for_own_game' do
    describe 'after a user creates a new game' do
      it 'makes a user a collaborator on their own game' do
        @c5 = Collaborator.create!( game_id: @g3.id, user_id: @u2.id, requested: true, accepted: true )
        expect( @c5.requested ).to be true
        expect( @c5.accepted ).to be true
      end

      it 'requires the game\'s id and user id to match the collaborator game id and user id' do
        @c5 = Collaborator.create!( game_id: @g3.id, user_id: @u2.id, requested: true, accepted: true )
        expect( @g3.id ).to eq( @c5.game_id )
        expect( @g3.user_id ).to eq( @c5.user_id )
      end
    end
  end

  describe '#remake_collaboration_request' do
    it 'finds a collaborator given the game id and user id' do
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id)
      expect( @collaborator ).to eq( @c2 )
    end

    it 'flips the value of the requested boolean while leaving the accepted value' do
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id)
      Collaborator.flip_requested_value(@collaborator)
      @collaborator.save!
      expect( @collaborator.requested ).to be true
      expect( @collaborator.accepted ).to be false
    end
  end

  describe '#update_requested_status' do
    it 'finds a game by id' do
      @game = Game.find(@g1.id)
      expect( @game.name ).to eq( 'neature' )
    end

    it 'determines if the game creator is the user id in the header' do
      @game = Game.find(@g1.id)
      expect( @game.user_id == @u1.id ).to be true
      expect( @game.user_id == @u2.id ).to be false
    end

    it 'flips the value of the requested boolean while leaving the accepted value' do
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id)
      Collaborator.flip_requested_value(@collaborator)
      @collaborator.save!
      expect( @collaborator.requested ).to be true
      expect( @collaborator.accepted ).to be false
    end
  end

  describe '#make_collaborator' do
    it 'finds a game by id' do
      @game = Game.find(@g1.id)
      expect( @game.name ).to eq( 'neature' )
    end

    it 'determines if the game creator is the user id in the header' do
      @game = Game.find(@g1.id)
      expect( @game.user_id == @u1.id ).to be true
      expect( @game.user_id == @u2.id ).to be false
    end

    it 'flips the value of the accepted boolean while leaving the requested value' do
      @collaborator = Collaborator.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id)
      Collaborator.flip_accepted_value(@collaborator)
      @collaborator.save!
      expect( @collaborator.requested ).to be false
      expect( @collaborator.accepted ).to be true
    end
  end

  describe '#find_game_requesters_and_collaborators' do
    it 'finds all collaboration requests, accepted or not, for a given game' do
      @collaborators = Collaborator.where('game_id = ? AND requested = ?', @g2.id, true)
      expect( @collaborators.count ).to eq( 3 )
      expect( @collaborators.first.user_id ).to eq( @u1.id )
      expect( @collaborators.last.user_id ).to eq( @u2.id )
    end
  end

  describe '#find_game_requesters' do
    it 'finds all collaborations for a given game where accepted is false' do
      @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', @g1.id, true, false)
      expect( @collaborators.count ).to eq( 0 )
    end
  end

  describe '#find_game_collaborators' do
    it 'finds all collaborations for a given game where accepted is true' do
      @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', @g1.id, true, true)
      expect( @collaborators.count ).to eq( 1 )
      expect( @collaborators.first.user_id ).to eq( @u1.id )
    end
  end

  describe '#find_user_collaborators' do
    before do
      @games = Game.where(user_id: @u1.id)
      @ids = []
      @games.each do |game|
        @ids << game.id
      end
      @collabs = []
      @ids.each do |id|
        @collaborators = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, true)
        @collabs.concat(@collaborators)
      end
    end

    it 'finds all game ids for a user\'s created games' do
      expect( @ids.count ).to eq( 2 )
      expect( @ids.first ).to eq( @g1.id )
      expect( @ids.last ).to eq( @g2.id )
    end

    it 'uses the game ids for a user\'s created games to find collaborators for those games' do
      expect( @collabs.count ).to eq( 3 )
      expect( @collabs.first ).to eq( @c1 )
      expect( @collabs.last ).to eq( @c4 )
    end
  end

  describe '#find_user_requesters' do
    before do
      @games = Game.where(user_id: @u1.id)
      @ids = []
      @games.each do |game|
        @ids << game.id
      end
      @questers = []
      @ids.each do |id|
        @requesters = Collaborator.where('game_id = ? AND requested = ? AND accepted = ?', id, true, false)
        @questers.concat(@requesters)
      end
    end

    it 'finds all game ids for a user\'s created games' do
      expect( @ids.count ).to eq( 2 )
      expect( @ids.first ).to eq( @g1.id )
      expect( @ids.last ).to eq( @g2.id )
    end

    it 'uses the game ids for a user\'s created games to find requesters for those games' do
      expect( @questers.count ).to eq( 1 )
    end
  end

  describe '#find_collaborations_by_user' do
    before do
      @collaborators = Collaborator.where('user_id = ? AND requested = ? AND accepted = ?', @u1.id, true, true)
      @game_ids = []
      @collaborators.each do |t|
        @game_ids << t.game_id
      end

      @games = []
      @game_ids.each do |id|
        @game = Game.find_by(id: id)
        if @game.user_id != @u1.id
          @games << @game
        end
      end

      @users = []
      @games.each do |g|
        @user = User.find_by(id: g[:user_id])
        @users << @user.username
      end
    end

    it 'finds all game ids for a user\'s collaborations' do
      expect( @collaborators.count ).to eq( 3 )
      expect( @collaborators.first ).to eq( @c1 )
      expect( @collaborators.last ).to eq( @c7 )
    end

    it 'finds games by game ids and returns all games the user is not the creator of' do
      expect( @games.count ).to eq( 1 )
      expect( @games.first ).to eq( @g3 )
    end

    it 'find the creator usernames of games the user is a collaborator of and not creator of' do
      expect( @users.count ).to eq( 1 )
      expect( @users.first ).to eq( 'planetglobe' )
    end
  end
end
