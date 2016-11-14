require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:username) { "Taco" }
  describe "POST create" do
    describe "with correct params" do
      it "saves a user if username included in the post" do
        expect {
          post :create, params: { user: { username: username } }
        }.to change { User.count }.by(1)
      end
    end
  end
end
