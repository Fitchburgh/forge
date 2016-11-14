require 'rails_helper'

RSpec.describe UsersController do
  describe '#create' do
    it 'does not save a user if username not included' do
      expect {
        User.create!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'does not save a user if invalid attribute included' do
      expect {
        User.create!(user: 'Taco')
      }.to raise_error(ActiveRecord::UnknownAttributeError)
    end

    it 'saves a user if given a username that is unique' do
      expect { should validate_uniqueness_of(username).case_insensitive }
      expect { User.create!(username: 'Taco') }.to change{ User.count }.by(1)
    end
  end
end
