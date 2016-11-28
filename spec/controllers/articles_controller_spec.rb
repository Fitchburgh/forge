require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  before do
    @b1 = Background.create!( name: 'tree', tags: 'oak tree, tall tree, nature', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b2 = Background.create!( name: 'pirate ship', tags: 'ship, boat', user_id: 1, game_id: 15, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b3 = Background.create!( name: 'nature', tags: 'grass, bush, tree', user_id: 2, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @b4 = Background.create!( name: 'hut', tags: 'house, dwelling', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o1 = Obstacle.create!( name: 'bush', tags: 'shrub, nature', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o2 = Obstacle.create!( name: 'cannon', tags: 'weapon', user_id: 1, game_id: 15, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @o3 = Obstacle.create!( name: 'acorns', tags: 'nature', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e1 = Entity.create!( name: 'blackbeard', tags: 'pirate, person', user_id: 1, game_id: 15, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e2 = Entity.create!( name: 'squirrel', tags: 'mammal, creature', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e3 = Entity.create!( name: 'cyclopse', tags: 'creature, monster', user_id: 1, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
    @e4 = Entity.create!( name: 'dude', tags: 'person, man', user_id: 2, game_id: 5, info: 'stuff', published: true, thumbnail: 'less stuff' )
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
    before do
      @game = Game.create!(
        name: 'moles',
        tags: 'ground mammals, rpg',
        user_id: 1,
        description: '',
        info: 'game info',
        published: true,
        archived: false,
        score: 200,
        plays: 214,
        thumbnail: 'stuff'
      )
    end

    describe 'given correct params' do
      before do
        @v1 = Event.create!( name: 'jump', tags: 'leap', category: 'collision', info: 'blah', user_id: 1, game_id: 5, published: true )
        @v2 = Event.create!( name: 'swim', tags: 'breaststroke, freestyle', category: 'collision', info: 'blah', user_id: 1, game_id: 5, published: true )
        @v3 = Event.create!( name: 'talk', tags: 'chat, speak', category: 'text', info: 'blah', user_id: 1, game_id: 5, published: true )
      end

      it 'finds the game by id' do
        @g = Game.find(@game.id)
        expect( @g.name ).to eq( 'moles' )
      end

      it 'returns all backgrounds for a given game id' do
        expect( Background.find_background_by_game(@backgrounds, 5).count ).to eq( 3 )
      end

      it 'returns all obstacles for a given game id' do
        expect( Obstacle.find_obstacle_by_game(@obstacles, 5).count ).to be( 2 )
      end

      it 'returns all entities for a given game id' do
        expect( Entity.find_entity_by_game(@entities, 5).count ).to be( 3 )
      end

      it 'returns all events for a given game id' do
        expect( Event.find_event_by_game(@events, 5).count ).to be( 3 )
      end

      it 'returns all backgrounds, obstacles, events, and entities for a given game' do
        @backgrounds = Background.find_background_by_game(@backgrounds, 5)
        @obstacles = Obstacle.find_obstacle_by_game(@obstacles, 5)
        @entities = Entity.find_entity_by_game(@entities, 5)
        @events = Event.find_event_by_game(@events, 5)
        expect( @backgrounds.count + @obstacles.count + @entities.count + @events.count ).to eq( 11 )
      end
    end
  end
end
