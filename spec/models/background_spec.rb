require 'rails_helper'

RSpec.describe Background do
  before do
    @u1 = User.create
    @g1 = Game.create
    @bvalid = Background.create(user_id: 1, game_id: 1, info: '{big: list, of: stuff}', tags: '[things]', name: 'go-rund')
    @no_info = Background.create(user_id: 1, game_id: 1, tags: '[things]', name: 'go-rund')
    @no_tags = Background.create(user_id: 1, game_id: 1, info: '{big: list, of: stuff}', name: 'go-rund')
    @no_name = Background.create(user_id: 1, game_id: 1, info: '{big: list, of: stuff}', tags: '[things]')
  end

  describe "validations" do
    before do

    end

    it 'is valid' do
      expect(@bvalid).to be_valid
    end
    it 'is not valid without info object' do
      expect(@no_info).to_not be_valid
    end
    it 'is not valid without tags' do
      expect(@no_tags).to_not be_valid
    end
    it 'is not valid without a name' do
      expect(@no_name).to_not be_valid
    end
    it 'presence is set to true upon creation by default' do
      expect(@bvalid.presence).to be true
    end
  end
end
