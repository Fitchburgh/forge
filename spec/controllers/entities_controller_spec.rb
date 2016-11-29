require 'rails_helper'

RSpec.describe EntitiesController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff' )
    @e1 = Entity.create!( name: 'bird', tags: 'larch, animal', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e2 = Entity.create!( name: 'ferret', tags: 'mongoose, weasel, mammal, animal', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e3 = Entity.create!( name: 'beetle', tags: 'dung beetle, insect', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @e4 = Entity.create!( name: 'crab', tags: 'snow crab, animal', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
  end

  describe '#index' do
    it 'returns all entities' do
      expect( Entity.all.count ).to eq( 4 )
    end
  end

  describe '#create' do
    describe 'given correct params' do
      it 'finds the newly created entity' do
        expect( Entity.find(@e1.id) ).to eq @e1
      end
    end

    describe 'given incorrect params' do
      it 'raises an invalid record error if user does not exist' do
        expect{ Entity.create!(
          info: 'info',
          user_id: 11111,
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user param not given' do
        expect{ Entity.create!(
          info: 'info',
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if info param not given' do
        expect{ Entity.create!(
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game id param not given' do
        expect{ Entity.create!(
          info: 'info',
          user_id: @u1.id,
          published: false,
          name: 'game name',
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if name param not given' do
        expect{ Entity.create!(
          info: 'info',
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          tags: 'tags, many tags',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if tags param not given' do
        expect{ Entity.create!(
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
    it 'returns all entities whose name or tags include user input' do
      result = []
      Entity.all.each do |b|
        result <<b if b.tags.include?('animal') || b.name.include?('animal')
      end
      expect( result.count ).to eq( 3 )
    end
  end

  describe '#update' do
    describe 'given an invalid entity id' do
      it 'returns an error http status' do
        expect{ Entity.find(1234) }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end

    describe 'given a valid entity id' do
      it 'finds the entity to update' do
        expect( Entity.find(@e1.id) ).to eq( @e1 )
      end

      describe 'given correct params' do
        it 'updates the entity' do
          @entity = Entity.find(@e1.id)
          @entity.info = 'newly info'
          @entity.user_id = @u1.id
          @entity.game_id = @g2.id
          @entity.published = true
          @entity.name = 'beaver'
          @entity.tags = 'water creature, mammal'
          @entity.thumbnail = 'newly thumbnail'
          @entity.save!
          expect( @entity.thumbnail ).to eq( 'newly thumbnail' )
        end
      end
    end
  end

  describe '#delete' do
    describe 'given a valid entity id' do
      it 'finds the entity to update' do
        expect( Entity.find(@e4.id) ).to eq( @e4 )
      end

      it 'deletes the entity' do
        @e4.delete
        expect( Entity.all.count ).to eq( 3 )
      end
    end
  end
end
