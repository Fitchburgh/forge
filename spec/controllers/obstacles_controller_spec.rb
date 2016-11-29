require 'rails_helper'

RSpec.describe ObstaclesController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'navy vs navy', tags: 'boats, game', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @o1 = Obstacle.create!( name: 'staircase', tags: 'asdf', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o2 = Obstacle.create!( name: 'kettle', tags: 'cauldron', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o3 = Obstacle.create!( name: 'boat', tags: 'sailboat', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o4 = Obstacle.create!( name: 'tree', tags: 'tall tree, oak tree', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
  end
end
