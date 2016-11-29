require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before do
    @user = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @user2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @user.id, info: 'lots of stuff', published: true, archived: false, score: 100, plays: 12, thumbnail: 'asdf' )
    @g2 = Game.create!( name: 'navy vs navy', tags: 'boats, game', description: 'seafare at it\'s finest', user_id: @user.id, info: 'lots of stuff', published: true, archived: false, score: 150, plays: 123, thumbnail: 'asdf' )
    @b1 = Background.create!( name: 'tree', tags: 'oak tree, tall tree, nature', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b2 = Background.create!( name: 'pirate ship', tags: 'ship, boat', user_id: @user.id, game_id: @g2.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b3 = Background.create!( name: 'nature', tags: 'grass, bush, tree', user_id: @user2.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b4 = Background.create!( name: 'hut', tags: 'house, dwelling', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o1 = Obstacle.create!( name: 'bush', tags: 'shrub, nature', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o2 = Obstacle.create!( name: 'cannon', tags: 'weapon', user_id: @user.id, game_id: @g2.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o3 = Obstacle.create!( name: 'acorns', tags: 'nature', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e1 = Entity.create!( name: 'blackbeard', tags: 'pirate, person', user_id: @user.id, game_id: @g2.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e2 = Entity.create!( name: 'squirrel', tags: 'mammal, creature', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e3 = Entity.create!( name: 'cyclopse', tags: 'creature, monster', user_id: @user.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e4 = Entity.create!( name: 'dude', tags: 'person, man', user_id: @user2.id, game_id: @g1.id, info: 'stuff', published: true, thumbnail: 'less stuff' )
  end

  describe "#search" do
    describe 'with correct params' do
      it 'returns all backgrounds where name or tags include the user input' do
        expect( Background.find_background_by_input(@backgrounds, 'tree').count ).to be( 2 )
        expect( Background.find_background_by_input(@backgrounds, 'ship').count ).to be( 1 )
        expect( Background.find_background_by_input(@backgrounds, 'shark').count ).to be( 0 )
      end

      it 'returns all obstacles where name or tags include the user input' do
        expect( Obstacle.find_obstacle_by_input(@obstacles, 'nature').count ).to be( 2 )
        expect( Obstacle.find_obstacle_by_input(@obstacles, 'pirate').count ).to be( 0 )
      end

      it 'returns all entities where name or tags include the user input' do
        expect( Entity.find_entity_by_input(@entities, 'person').count ).to be( 2 )
        expect( Entity.find_entity_by_input(@entities, 'werewolf').count ).to be( 0 )
      end

      it 'returns all articles where name or tags include the user input' do
        @backgrounds = Background.find_background_by_input(@backgrounds, 'nature')
        @obstacles = Obstacle.find_obstacle_by_input(@obstacles, 'nature')
        @entities = Entity.find_entity_by_input(@entities, 'nature')

        expect( @backgrounds.count + @obstacles.count + @entities.count ).to be( 4 )
      end
    end
  end

  describe '#find_game_articles' do
    describe 'given correct params' do
      before do
        @v1 = Event.create!( name: 'jump', tags: 'leap', category: 'collision', info: 'blah', user_id: @user.id, game_id: @g1.id, published: true )
        @v2 = Event.create!( name: 'swim', tags: 'breaststroke, freestyle', category: 'collision', info: 'blah', user_id: @user.id, game_id: @g1.id, published: true )
        @v3 = Event.create!( name: 'talk', tags: 'chat, speak', category: 'text', info: 'blah', user_id: @user.id, game_id: @g1.id, published: true )
      end

      it 'finds the game by id' do
        @g = Game.find(@g1.id)
        expect( @g.name ).to eq( 'neature' )
      end

      it 'returns all backgrounds for a given game id' do
        expect( Background.find_background_by_game(@backgrounds, @g1.id).count ).to eq( 3 )
      end

      it 'returns all obstacles for a given game id' do
        expect( Obstacle.find_obstacle_by_game(@obstacles, @g1.id).count ).to be( 2 )
      end

      it 'returns all entities for a given game id' do
        expect( Entity.find_entity_by_game(@entities, @g1.id).count ).to be( 3 )
      end

      it 'returns all events for a given game id' do
        expect( Event.find_event_by_game(@events, @g1.id).count ).to be( 3 )
      end

      it 'returns all backgrounds, obstacles, events, and entities for a given game' do
        @backgrounds = Background.find_background_by_game(@backgrounds, @g1.id)
        @obstacles = Obstacle.find_obstacle_by_game(@obstacles, @g1.id)
        @entities = Entity.find_entity_by_game(@entities, @g1.id)
        @events = Event.find_event_by_game(@events, @g1.id)
        expect( @backgrounds.count + @obstacles.count + @entities.count + @events.count ).to eq( 11 )
      end
    end
  end
end
