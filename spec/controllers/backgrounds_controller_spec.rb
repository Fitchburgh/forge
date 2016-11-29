require 'rails_helper'

RSpec.describe BackgroundsController, type: :controller do
  before do
    @b1 = Background.create!( name: 'ocean', tags: 'sea, water', user_id: 1, game_id: 1, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b2 = Background.create!( name: 'stream', tags: 'brook, water', user_id: 2, game_id: 1, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b3 = Background.create!( name: 'river', tags: 'Amazon, water', user_id: 2, game_id: 1, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b4 = Background.create!( name: 'lake', tags: 'Michigan', user_id: 1, game_id: 2, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
  end

  describe '#index' do
    it 'returns all backgrounds' do
      expect( Background.all.count ).to eq( 4 )
    end
  end
end
