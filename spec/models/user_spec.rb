require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "should not save user if username not present" do
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not save user if username not unique" do
      expect { should validate_uniqueness_of(:username).case_insensitive }
    end
  end
end
