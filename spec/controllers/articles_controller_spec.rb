require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:name) { 'Poppy' }

  describe "#create" do
    describe 'with correct params' do
      it 'creates a new background asset' do
        expect{ Background.create(name: name) }.to change{ Background.count }.by(1)
      end
      it 'creates a new obstacle asset' do
        expect{ Obstacle.create(name: name) }.to change{ Obstacle.count }.by(1)
      end
      it 'creates a new entity asset' do
        expect{ Entity.create(name: name) }.to change{ Entity.count }.by(1)
      end
    end

    describe 'with incorrect params' do
      it 'does not create a new background asset' do
        expect{ Background.create(description: 'Texty text') }.not_to change{ Background.count }
      end

      it 'does not create a new background given no name' do
        expect{ Background.create(name: nil) }.not_to change{ Background.count }
      end

      it 'does not create a new obstacle asset' do
        expect{ Obstacle.create(description: 'Texty text') }.not_to change{ Obstacle.count }
      end

      it 'does not create a new obstacle asset' do
        expect{ Obstacle.create(name: nil) }.not_to change{ Obstacle.count }
      end

      it 'does not create a new entity asset' do
        expect{ Entity.create(description: 'Text text') }.not_to change{ Entity.count }
      end

      it 'does not create a new entity asset' do
        expect{ Entity.create(name: nil) }.not_to change{ Entity.count }
      end
    end
  end

end
