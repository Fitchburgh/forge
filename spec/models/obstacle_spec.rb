require 'rails_helper'

RSpec.describe Obstacle do
  describe "validations" do
    it "should not save if the obstacle does not have a JSON object" do
      expect {
        Obstacle.create!(user_id: 1, scene_id: 1, name: "tree", tags: "['oak', 'tall tree']")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save if the obstacle does not have a name" do
      expect {
        Obstacle.create!(user_id: 1, scene_id: 1, info: "{stuff}", tags: "['oak', 'tall tree']")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
