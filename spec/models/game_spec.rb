require 'rails_helper'

RSpec.describe Game do
  describe "validations" do
    it "should not save if the game does not have a name" do
      expect {
        Game.create!(user_id: 10, description: "puzzle rpg")
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save if the game does not have a unique name" do
      expect { should validate_uniqueness_of(:name).case_insensitive }
    end
  end
end
