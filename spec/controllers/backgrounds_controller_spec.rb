require 'rails_helper'

RSpec.describe BackgroundsController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'navy vs navy', tags: 'boats, game', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @b1 = Background.create!( name: 'ocean', tags: 'sea, water', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b2 = Background.create!( name: 'stream', tags: 'brook, water', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b3 = Background.create!( name: 'river', tags: 'Amazon, water', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @b4 = Background.create!( name: 'lake', tags: 'Michigan', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
  end

  describe '#index' do
    it 'returns all backgrounds' do
      expect( Background.all.count ).to eq( 4 )
    end
  end

  describe '#create' do
    describe 'given correct params' do
      it 'finds the newly created background' do
        expect( Background.find(@b1.id) ).to eq @b1
      end
    end

    describe 'given incorrect params' do
      it 'raises an invalid record error if user does not exist' do
        expect{ Background.create!(
          info: 'info',
          user_id: 11111,
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game does not exist' do
        expect{ Background.create!(
          info: 'info',
          user_id: @u1.id,
          game_id: 124,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user param not given' do
        expect{ Background.create!(
          info: 'info',
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if info param not given' do
        expect{ Background.create!(
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game id param not given' do
        expect{ Background.create!(
          info: 'info',
          user_id: @u1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if name param not given' do
        expect{ Background.create!(
          info: 'info',
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if tags param not given' do
        expect{ Background.create!(
          info: 'info',
          user_id: @u1.id,
          game_id: @g1.id,
          name: 'game name',
          published: false,
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe '#search' do
    it 'returns all backgrounds whose name or tags include user input' do
      result = []
      Background.all.each do |b|
        result <<b if b.tags.include?('water') || b.name.include?('water')
      end

      expect( result.count ).to eq( 3 )
    end
  end

  describe '#update' do
    describe 'given an invalid background id' do
      it 'returns an error http status' do
        expect{ Background.find(1234) }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end

    describe 'given a valid background id' do
      it 'finds the background to update' do
        expect( Background.find(@b1.id) ).to eq( @b1 )
      end

      describe 'given correct params' do
        it 'updates the background' do
          @background = Background.find(@b1.id)
          @background.info = 'new info'
          @background.user_id = @u1.id
          @background.game_id = @g2.id
          @background.published = true
          @background.name = 'ocean'
          @background.tags = 'water, sea, pacific'
          @background.thumbnail = 'new thumb'
          @background.save!
          expect( @background.thumbnail ).to eq( 'new thumb' )
        end
      end
    end
  end

  describe '#delete' do
    describe 'given a valid background id' do
      it 'finds the background to update' do
        expect( Background.find(@b4.id) ).to eq( @b4 )
      end

      it 'deletes the background' do
        @b4.delete
        expect( Background.all.count ).to eq( 3 )
      end
    end
  end
end
