require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should not have a blank name' do
      @user = User.new(name: nil, email: 'fake@email.com', password: '1234567890', password_confirmation: '1234567890')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not have a blank email' do
      @user = User.new(name: "Vince", email: nil, password: '1234567890', password_confirmation: '1234567890')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should not have a blank password field' do
      @user = User.new(name: "Vince", email: 'fake@email.com', password: nil, password_confirmation: 'somethingelse')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should not have mismatched password and password_confirmation' do
      @user = User.new(name: "Vince", email: 'fake@email.com', password: '1234567890', password_confirmation: 'somethingelse')
      @user.save
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should not add non-unique email' do
      @user = User.new(name: "Vince", email: 'fake@email.com', password: '1234567890', password_confirmation: '1234567890')
      @user.save

      @user2 = User.new(name: "Vince", email: 'fake@email.com', password: '1234567890', password_confirmation: '1234567890')
      @user2.save
      
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not add non-unique email regardless of case' do
      @user = User.new(name: "Vince", email: 'FAKE@email.com', password: '1234567890', password_confirmation: '1234567890')
      @user.save

      @user2 = User.new(name: "Vince", email: 'fake@email.COM', password: '1234567890', password_confirmation: '1234567890')
      @user2.save

      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it 'should have a password with a minimum length of 3 characters' do
      @user = User.new(name: "Vince", email: 'FAKE@email.com', password: '12', password_confirmation: '12')
      @user.save
      
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")

    end

  end


  describe '.authenticate_with_credentials' do

    it 'should be granted login access if all credentials are valid' do
      @user = User.create(name: 'Vince', email: 'fake@email.com', password: '1234567890', password_confirmation: '1234567890')
      @login = User.authenticate_with_credentials('fake@email.com', '1234567890')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should be granted login access if all credentials are valid regardless of email case' do
      @user = User.create(name: 'Vince', email: 'fake@email.COM', password: '1234567890', password_confirmation: '1234567890')
      @login = User.authenticate_with_credentials('FAKE@email.com', '1234567890')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should be granted login access regardless of case or whitespace in email' do
      @user = User.create(name: 'Vince', email: 'FAKE@email.cOm', password: '1234567890', password_confirmation: '1234567890')
      @login = User.authenticate_with_credentials('    fake@email.COM', '1234567890')
      
      expect(@user).to be_valid
      expect(@login).to eq(@user)
    end

    it 'should NOT be granted login access if credentials are invalid' do
      @user = User.create(name: 'Vince', email: 'fake@email.com', password: '1234567890', password_confirmation: '1234567890')
      @login = User.authenticate_with_credentials('fake@email.com', 'incorrectpassword')
      
      expect(@user).to_not eq(@login)
      expect(@login).to eq(nil)
    end

  end
end
