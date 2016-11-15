require 'rails_helper'

RSpec.describe UsersController do
  before do
    @alpha = User.create!(username: 'alpha', token: 'asdf1234', uid: '12345678')
    @beta = User.create!(username: 'beta', token: 'hhhh893', uid: '87765431')
    @gamma = User.create!(username: 'gamma', token: 'yuio9909', uid: '657483920')
  end
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
      expect { User.create!(username: 'Taco', uid: '12345', token: 'asdf4321') }.to change{ User.count }.by(1)
    end
  end

  describe '#current_user' do
    describe 'when given a correct user token' do
      it 'finds the current user' do
        expect(User.find_by(token: 'asdf1234')).to eq @alpha
      end
    end

    # describe 'when given an incorrect user token' do
    #   it 'renders a status 404 error' do
    #     expect(User.find_by(token: 'as34')).to have_http_status 404
    #   end
    # end
  end

  # describe '#login' do
  #   
  # end
end
