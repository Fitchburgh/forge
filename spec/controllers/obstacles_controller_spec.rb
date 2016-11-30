require 'rails_helper'

RSpec.describe ObstaclesController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'navy vs navy', tags: 'boats, game', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @o1 = Obstacle.create!( name: 'staircase', tags: 'wooden', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o2 = Obstacle.create!( name: 'kettle', tags: 'cauldron', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o3 = Obstacle.create!( name: 'boat', tags: 'sailboat', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
    @o4 = Obstacle.create!( name: 'tree', tags: 'tall tree, oak tree, wood', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, thumbnail: 'more stuff' )
  end

  describe '#index' do
    it 'returns all obstacles' do
      expect( Obstacle.all.count ).to eq( 4 )
    end
  end

  describe '#create' do
    describe 'given correct params' do
      it 'finds the newly created obstacle' do
        expect( Obstacle.find(@o1.id) ).to eq @o1
      end
    end

    describe 'given incorrect params' do
      it 'raises an invalid record error if user does not exist' do
        expect{ Obstacle.create!(
          info: 'infoo',
          user_id: 11111,
          game_id: @g1.id,
          published: false,
          name: 'vehicle',
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game does not exist' do
        expect{ Obstacle.create!(
          info: 'infoo',
          user_id: @u1.id,
          game_id: 124,
          published: false,
          name: 'vehicle',
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user param not given' do
        expect{ Obstacle.create!(
          info: 'infoo',
          game_id: @g1.id,
          published: false,
          name: 'vehicle',
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if info param not given' do
        expect{ Obstacle.create!(
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          name: 'vehicle',
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game id param not given' do
        expect{ Obstacle.create!(
          info: 'infoo',
          user_id: @u1.id,
          published: false,
          name: 'vehicle',
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if name param not given' do
        expect{ Obstacle.create!(
          info: 'infoo',
          user_id: @u1.id,
          game_id: @g1.id,
          published: false,
          tags: 'car, truck',
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if tags param not given' do
        expect{ Obstacle.create!(
          info: 'infoo',
          user_id: @u1.id,
          game_id: @g1.id,
          name: 'vehicle',
          published: false,
          thumbnail: 'thumbnail'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe '#search' do
    it 'returns all obstacles whose name or tags include user input' do
      result = []
      Obstacle.all.each do |b|
        result <<b if b.tags.include?('wood') || b.name.include?('wood')
      end

      expect( result.count ).to eq( 2 )
    end
  end

  describe '#update' do
    describe 'given an invalid obstacle id' do
      it 'returns an error http status' do
        expect{ Obstacle.find(1234) }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end

    describe 'given a valid obstacle id' do
      it 'finds the obstacle to update' do
        expect( Obstacle.find(@o1.id) ).to eq( @o1 )
      end

      describe 'given correct params' do
        it 'updates the obstacle' do
          @obstacle = Obstacle.find(@o1.id)
          @obstacle.info = 'new info'
          @obstacle.user_id = @u1.id
          @obstacle.game_id = @g2.id
          @obstacle.published = true
          @obstacle.name = 'lamp'
          @obstacle.tags = 'light'
          @obstacle.thumbnail = 'thumbnail 2.0'
          @obstacle.save!
          expect( @obstacle.name ).to eq( 'lamp' )
        end
      end
    end
  end

  describe '#delete' do
    describe 'given a valid obstacle id' do
      it 'finds the obstacle to update' do
        expect( Obstacle.find(@o4.id) ).to eq( @o4 )
      end

      it 'deletes the obstacle' do
        @o4.delete
        expect( Obstacle.all.count ).to eq( 3 )
      end
    end
  end
end
