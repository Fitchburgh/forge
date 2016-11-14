require 'rails_helper'

RSpec.describe Scene, type: :model do
  describe "validations" do
    it "should not save scene if it does not have a name" do
      expect {
        Scene.create!(map_id: 3, description: "captain's quarters")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
