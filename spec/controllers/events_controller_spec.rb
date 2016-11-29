require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
    @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
    @g1 = Game.create!( name: 'neature', tags: 'thats pretty neat', description: 'you can tell its a game from the way it is', user_id: @u1.id, info: 'lots of stuff' )
    @g2 = Game.create!( name: 'kreature kombat', tags: 'fighting', description: 'seafare at it\'s finest', user_id: @u1.id, info: 'lots of stuff' )
    @g3 = Game.create!( name: 'flyy', tags: 'adventure', description: 'it\'s just a maze', user_id: @u2.id, info: 'lots of stuff' )
    @e1 = Event.create!( name: 'die', category: 'collision', user_id: @u1.id, game_id: @g2.id, info: 'lots of stuff', published: true, tags: 'death, dead, ded, not alive' )
    @e2 = Event.create!( name: 'fish', category: 'collision', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, tags: 'leisure activity' )
    @e3 = Event.create!( name: 'climb', category: 'collision', user_id: @u2.id, game_id: @g1.id, info: 'lots of stuff', published: true, tags: 'leisure, rock climb, rope climb' )
    @e4 = Event.create!( name: 'swim', category: 'collision', user_id: @u1.id, game_id: @g1.id, info: 'lots of stuff', published: true, tags: 'not drown, breast stroke' )
  end

  describe "#index" do
    it 'returns all entities' do
      expect( Event.all.count ).to eq( 4 )
    end
  end

  describe "#create" do
    describe 'given correct params' do
      it 'finds the newly created event' do
        expect( Event.find(@e1.id) ).to eq @e1
      end
    end

    describe 'given incorrect params' do
      it 'raises an invalid record error if user does not exist' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          user_id: 4433,
          game_id: @g2.id,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game does not exist' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          user_id: @u1.id,
          game_id: 123,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if user param not given' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          game_id: @g2.id,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if name param not given' do
        expect{ Event.create!(
          category: 'collision',
          user_id: @u1.id,
          game_id: @g2.id,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if category param not given' do
        expect{ Event.create!(
          name: 'die',
          user_id: @u1.id,
          game_id: @g2.id,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if game id param not given' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          user_id: @u1.id,
          info: 'lots of stuff',
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if info param not given' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          user_id: @u1.id,
          game_id: @g2.id,
          published: true,
          tags: 'death, dead, ded, not alive'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it 'raises an invalid record error if tags param not given' do
        expect{ Event.create!(
          name: 'die',
          category: 'collision',
          user_id: @u1.id,
          game_id: @g2.id,
          info: 'lots of stuff',
          published: true
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe "#search" do
    it 'returns all events whose name or tags include user input' do
      result = []
      Event.all.each do |b|
        result <<b if b.tags.include?('leisure') || b.name.include?('leisure')
      end
      expect( result.count ).to eq( 2 )
    end
  end

  describe "#update" do
    describe 'given an invalid event id' do
      it 'returns an error http status' do
        expect{ Event.find(1234) }.to raise_error( ActiveRecord::RecordNotFound )
      end
    end

    describe 'given a valid event id' do
      it 'finds the event to update' do
        expect( Event.find(@e1.id) ).to eq( @e1 )
      end

      describe 'given correct params' do
        it 'updates the event' do
          @entity = Event.find(@e1.id)
          @entity.name = 'look'
          @entity.category = 'text'
          @entity.user_id = @u1.id
          @entity.game_id = @g2.id
          @entity.info = 'new new info'
          @entity.published = true
          @entity.tags = 'chat, chum it up, blabber'
          @entity.save!
          expect( @entity.name ).to eq( 'look' )
        end
      end
    end
  end

  describe '#delete' do
    describe 'given a valid event id' do
      it 'finds the event to update' do
        expect( Event.find(@e4.id) ).to eq( @e4 )
      end

      it 'deletes the event' do
        @e4.delete
        expect( Event.all.count ).to eq( 3 )
      end
    end
  end
end
