require 'rails_helper'

RSpec.describe CharactersController, type: :controller do
  # before do
  #   @u1 = User.create!(username: 'emanresu', token: 'asdKJFKNfsdJKDSNnfdsjnf', uid: 238879432983, google_oauth_data: 'placeholder' )
  #   @u2 = User.create!(username: 'planetglobe', token: 'pqowiURTBVncmxPQOWI', uid: 34123432123, google_oauth_data: 'placeholder' )
  #   @c1 = Character.create!( user_id: @u1.id, info: 'info', name: 'megaman', current: false )
  #   @c2 = Character.create!( user_id: @u1.id, info: 'info', name: 'dk', current: false )
  #   @c3 = Character.create!( user_id: @u1.id, info: 'info', name: 'kirby', current: true )
  #   @c4 = Character.create!( user_id: @u2.id, info: 'info', name: 'trex', current: true )
  #   @c5 = Character.create!( user_id: @u2.id, info: 'info', name: 'captain planet', current: false )
  # end
  #
  # describe '#index' do
  #   it 'returns all characters who\'s user id matches the user id from the header' do
  #     expect( Character.find_by(user_id: @u1.id).count ).to eq( 3 )
  #     expect( Character.find_by(user_id: @u2.id).count ).to eq( 2 )
  #   end
  # end

  # describe "GET #search" do
  #   it "returns http success" do
  #     get :search
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "#create" do
  #   before do
  #     @user = User.create!(username: 'dude', uid: '256807', token: '89jfa8j4983aj')
  #     @character = Character.create!(name: 'Manbearpig', user_id: @user.id, current: true, obj: "{json stuff}")
  #   end
  #
  #   it "returns a new character if it was created successfully" do
  #     get :create
  #     expect{ Character.create!(name: name, user_id: @user.id, current: current, obj: obj) }.to change{ Character.count }.by(1)
  #   end
  # end

  # describe "GET #delete" do
  #   it "returns http success" do
  #     get :delete
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
end
