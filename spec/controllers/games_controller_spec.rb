require 'rails_helper'

RSpec.describe GamesController do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff', archived: false, plays: 90, score: 150 )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff', archived: false, plays: 5, score: 125 )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff', archived: false, plays: 100, score: 300 )
    @g4 = Game.create!( name: 'rock paper scissors', tags: 'hand gesture game', description: 'you win 1/3 of the time, usually', user_id: @u2.id, info: 'lots of stuff', archived: false, plays: 200, score: 100 )
    @g5 = Game.create!( name: 'samurai slice', tags: 'fighting, rpg, sword fighting', description: 'none', user_id: @u1.id, info: 'lots of stuff', archived: false, plays: 5, score: 150 )
    @g6 = Game.create!( name: 'sailor jerry', tags: 'action, rpg, adventure', description: 'imagine popeye constantly on spinnach', user_id: @u2.id, info: 'lots of stuff', archived: true, plays: 250, score: 200 )
    @c1 = Collaborator.create!( game_id: @g1.id, user_id: @u1.id, requested: true, accepted: true )
    @c2 = Collaborator.create!( game_id: @g2.id, user_id: @u1.id, requested: true, accepted: true )
    @c3 = Collaborator.create!( game_id: @g3.id, user_id: @u2.id, requested: true, accepted: true )
    @c4 = Collaborator.create!( game_id: @g4.id, user_id: @u2.id, requested: true, accepted: true )
    @c5 = Collaborator.create!( game_id: @g5.id, user_id: @u1.id, requested: true, accepted: true )
    @c6 = Collaborator.create!( game_id: @g6.id, user_id: @u2.id, requested: true, accepted: true )
    @c7 = Collaborator.create!( game_id: @g5.id, user_id: @u2.id, requested: true, accepted: true )
    @c8 = Collaborator.create!( game_id: @g6.id, user_id: @u1.id, requested: true, accepted: false )
    @b1 = Background.create!( name: 'ocean', tags: 'sea, water', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b2 = Background.create!( name: 'stream', tags: 'brook, water', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b3 = Background.create!( name: 'river', tags: 'Amazon, water', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b4 = Background.create!( name: 'lake', tags: 'Michigan', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e1 = Entity.create!( name: 'bird', tags: 'larch, animal', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e2 = Entity.create!( name: 'ferret', tags: 'mongoose, weasel, mammal, animal', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e3 = Entity.create!( name: 'beetle', tags: 'dung beetle, insect', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e4 = Entity.create!( name: 'crab', tags: 'snow crab, animal', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o1 = Obstacle.create!( name: 'staircase', tags: 'asdf', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o2 = Obstacle.create!( name: 'kettle', tags: 'cauldron', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o3 = Obstacle.create!( name: 'boat', tags: 'sailboat', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o4 = Obstacle.create!( name: 'tree', tags: 'tall tree, oak tree', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
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

  describe "#delete" do
    describe 'given a valid game id' do
      it 'finds the game to update' do
        expect( Game.find(@g5.id) ).to eq( @g5 )
      end

      it 'archives the entity' do
        @game = Game.find(@g5.id)
        @game.archived = true
        @game.save!
        expect( @game.archived ).to be true
      end
    end
  end

  describe '#find_user_games' do
    describe 'when given a user id' do
      it 'returns all games that user created that are not yet archived' do
        @games = Game.where('user_id = ? AND archived = ?', @u1.id, false)
        expect( @games.count ).to eq( 3 )
      end

      it 'does not return orphan game whose game id is 0' do
        @game = Game.create!( id: 0, name: 'orphans', tags: 'tag', description: 'home of archived stuff', user_id: @u1.id, info: 'stuffing', archived: true )
        @games = Game.where('user_id = ? AND archived = ?', @u1.id, false)
        result = []
        @games.each do |game|
          if game.id > 0
            result << game
          end
        end
        expect( result.count ).to eq( 3 )
      end
    end
  end

  describe '#find_user_games_count' do
    it 'returns the count of how many games a user has created' do
      result = Game.where(user_id: @u2.id).count
      expect( result ).to eq( 3 )
    end
  end

  describe '#count_users' do
    it 'counts to the total number of users' do
      expect( User.all.count ).to eq( 2 )
    end
  end

  describe '#count_total_plays' do
    it 'counts the total number of plays for every published game' do
      @count = 0
      Game.all.each do |game|
        @count += game.plays
      end
      expect( @count ).to eq( 650 )
    end
  end

  describe '#count_total_articles' do
    it 'counts the total number of backgrounds, entities, and objects for all games' do
      expect( Background.all.count + Obstacle.all.count + Entity.all.count ).to eq( 12 )
    end
  end

  describe '#count_total_backgrounds' do
    it 'counts the total number of backgrounds for all games' do
      expect( Background.all.count ).to eq( 4 )
    end
  end

  describe '#count_total_obstacles' do
    it 'counts the total number of obstacles for all games' do
      expect( Obstacle.all.count ).to eq( 4 )
    end
  end

  describe '#count_total_entities' do
    it 'counts the total number of entities for all games' do
      expect( Entity.all.count ).to eq( 4 )
    end
  end

  describe '#count_articles_by_game' do
    it 'counts the total number of  for a specific game' do
      @backgrounds = Background.where(game_id: @g1.id).count
      @obstacles = Obstacle.where(game_id: @g1.id).count
      @entities = Entity.where(game_id: @g1.id).count
      expect( @backgrounds + @obstacles + @entities ).to eq( 9 )
    end
  end

  describe '#count_backgrounds_by_game' do
    it 'counts the total number of  for a specific game' do
      @backgrounds = Background.where(game_id: @g1.id).count
      expect( @backgrounds ).to eq( 3 )
    end
  end

  describe '#count_obstacles_by_game' do
    it 'counts the total number of  for a specific game' do
      @obstacles = Obstacle.where(game_id: @g1.id).count
      expect( @obstacles ).to eq( 3 )
    end
  end

  describe '#count_entities_by_game' do
    it 'counts the total number of  for a specific game' do
      @entities = Entity.where(game_id: @g1.id).count
      expect( @entities ).to eq( 3 )
    end
  end

  describe "#savegame" do
    it "returns the json object saved upon success of saving game" do
      expect(@save = SaveGame.create!(game_id: @g1.id, user_id: @u1.id, info: 'random info')).to eq @save
    end
  end

  describe '#add_user_play' do
    describe 'given correct params' do
      it 'creates a new count for a user playing a game for the first time' do
        expect{ GamePlay.create!(
          game_id: @g1.id,
          user_id: @u1.id,
          plays: 1
        )}.to change{ GamePlay.count }.by(1)
      end
    end

    describe 'given incorrect params' do
      it 'does not create a new game play if game id not valid' do
        expect{ GamePlay.create!( game_id: 4321, user_id: @u1.id, plays: 1 ) }.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'does not create a new game play if user id not valid' do
        expect{ GamePlay.create!( game_id: @g1.id, user_id: 1234, plays: 1 ) }.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe '#update_user_play' do
    before do
      GamePlay.create!( game_id: @g1.id, user_id: @u1.id, plays: 1 )
    end

    describe 'given correct params' do
      it 'increments the play counter by 1' do
        @play = GamePlay.find_by('game_id = ? AND user_id = ?', @g1.id, @u1.id)
        @play.increment!(:plays)
        expect( @play.plays ).to eq( 2 )
      end
    end
  end

  describe '#count_user_game_plays' do
    before do
      GamePlay.create!( game_id: @g1.id, user_id: @u1.id, plays: 1 )
    end

    describe 'given valid params' do
      it 'counts the play counter for a given user' do
        @play = GamePlay.find_by('game_id = ? AND user_id = ?', @g1.id, @u1.id)
        expect( @play.plays ).to eq( 1 )
      end
    end

    describe 'when searching for a user that has not played a game' do
      it 'returns gameplay as nil' do
        expect( GamePlay.find_by('game_id = ? AND user_id = ?', @g1.id, @u2.id) ).to be nil
      end
    end
  end

  describe '#count_game_users' do
    before do
      GamePlay.create!( game_id: @g1.id, user_id: @u1.id, plays: 1 )
    end

    it 'counts the number of users who have played a given game' do
      expect( GamePlay.where(game_id: @g1.id).count ).to eq( 1 )
    end
  end

  describe '#update_game_score' do
    describe 'given a valid game id' do
      it 'updates the score of the game' do
        @game = Game.find(@g6.id)
        @game.score = 100
        @game.save!
        expect( @game.score ).to eq( 100 )
      end
    end

    describe 'give an invalid game id' do
      it 'returns an invalid response error' do
        expect{ Game.find(4321) }.to raise_error{ ActiveRecord::RecordInvalid }
      end
    end
  end
end
