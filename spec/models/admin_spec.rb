require 'rails_helper'

RSpec.describe Admin, type: :model do
  before do
    @a1 = Admin.create(first: 'brandon', last: 'fitch', email: 'taco@pies.com', username: 'tacopies', password: 'password')
    @a2 = Admin.create(last: 'fitch', email: 'taco@pies.com', username: 'tacopies', password: 'password')
    @a3 = Admin.create(first: 'brandon', email: 'taco@pies.com', username: 'tacopies', password: 'password')
    @a4 = Admin.create(first: 'brandon', last: 'fitch', username: 'tacopies', password: 'password')
    @a5 = Admin.create(first: 'brandon', last: 'fitch', email: 'taco@pies.com', password: 'password')
    @a6 = Admin.create(first: 'brandon', last: 'fitch', email: 'taco@pies.com', username: 'tacopies')
  end

  it "is valid with valid attributes" do
    expect(@a1).to be_valid
  end
  it "is not valid without a first" do
    expect(@a2).to_not be_valid
  end
  it "is not valid without a last" do
    expect(@a3).to_not be_valid
  end
  it "is not valid without a email" do
    expect(@a4).to_not be_valid
  end
  it "is not valid without a username" do
    expect(@a5).to_not be_valid
  end
  it "is not valid without a password" do
    expect(@a6).to_not be_valid
  end
end
