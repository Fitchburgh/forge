require 'rails_helper'

RSpec.describe Entity do
  describe "validations" do
    it "should not save if the entity does not have a JSON object" do
      expect {
        Entity.create!(user_id: 1, scene_id: 1, name: "tree", tags: "['oak', 'tall tree']")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save if the entity does not have a name" do
      expect {
        Entity.create!(user_id: 1, scene_id: 1, obj: "{stuff}", tags: "['oak', 'tall tree']")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
