require 'rails_helper'
require 'pry'

RSpec.describe AdminsController, type: :controller do
  describe "#create" do
    describe 'given all admin params' do
      before do
        @admin = Admin.create!(username: 'sampleusr', first: 'John', last: 'Doe', email: 'jdoe@email.com', password: 'pswd123', password_confirmation: 'pswd123' )
      end

      it "saves the admin with the given params" do
        expect(@admin.username).to eq( 'sampleusr' )
        expect(@admin.first).to eq( 'john' )
        expect(@admin.last).to eq( 'doe' )
        expect(@admin.email).to eq( 'jdoe@email.com' )
      end
    end

    describe 'given incorrect params' do
      it "returns a RecordInvalid error when no username param given" do
        expect{ Admin.create!(
          first: 'John',
          last: 'Doe',
          email: 'jdoe@email.com',
          password: 'pswd123',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when username is less than four characters" do
        expect{ Admin.create!(
          username: 'jd',
          first: 'John',
          last: 'Doe',
          email: 'jdoe@email.com',
          password: 'pswd123',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when no first name param given" do
        expect{ Admin.create!(
          username: 'johnd',
          last: 'Doe',
          email: 'jdoe@email.com',
          password: 'pswd123',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when no last name param given" do
        expect{ Admin.create!(
          username: 'johnd',
          first: 'John',
          email: 'jdoe@email.com',
          password: 'pswd123',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when no email param given" do
        expect{ Admin.create!(
          username: 'johnd',
          first: 'John',
          last: 'Doe',
          password: 'pswd123',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when password and password_confirmation don't match" do
        expect{ Admin.create!(
          username: 'johnd',
          first: 'John',
          last: 'Doe',
          email: 'jdoe@email.com',
          password: 'pswd123',
          password_confirmation: 'otherpswd'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end

      it "returns a RecordInvalid error when no password param given" do
        expect{ Admin.create!(
          username: 'johnd',
          first: 'John',
          last: 'Doe',
          email: 'jdoe@email.com',
          password_confirmation: 'pswd123'
        )}.to raise_error( ActiveRecord::RecordInvalid )
      end
    end
  end

  describe "#show" do
    it "finds a user by their admin ID" do
      @admin = Admin.create!(username: 'sampleusr', first: 'John', last: 'Doe', email: 'jdoe@email.com', password: 'pswd123', password_confirmation: 'pswd123', api_key: 111222333444)
      result = Admin.find(@admin.id)

      expect( result.username ).to eq( 'sampleusr' )
    end

    it "returns nil if admin not found" do
      expect{ Admin.find(888) }.to raise_error( ActiveRecord::RecordNotFound )
    end
  end
end
