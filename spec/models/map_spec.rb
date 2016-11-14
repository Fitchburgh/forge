require 'rails_helper'

RSpec.describe Map, type: :model do
  describe "validations" do
    it "should not save if the map does not have a name" do
      expect {
        Map.create!(game_id: 4, description: "pirate ship")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
