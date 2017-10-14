require "rails_helper"
describe User do
describe 'validations' do
it 'has valid factory' do
user = build(:user)
expect(user).to be_valid
end
describe 'presence' do
it 'is invalid without email' do
user = build(:user, email: '')
expect(user).to_not be_valid
end
it 'is invalid without first_name' do
user = build(:user, first_name: '')
expect(user).to_not be_valid
end
it 'is invalid without last_name' do
user = build(:user, last_name: '')
expect(user).to_not be_valid
end
it 'is invalid without password' do
  user = build(:user, password: '')
  expect(user).to_not be_valid
end
it 'is invalid with long empty password' do
  user = build(:user, password: '' * 6 )
  expect(user).to_not be_valid
end
it 'is invalid without password' do
  user = build(:user, password: '')
  expect(user).to_not be_valid
end
it 'is invalid with long empty password' do
  user = build(:user, password: '' * 6)
  expect(user).to_not be_valid
end
end
describe 'length' do
  it 'is invalid with too long first_name' do
    user = build(:user, first_name: 'a' * 51)
    expect(user).to_not be_valid
end
  it 'is invalid with too long last_name' do
    user = build(:user, last_name: 'a' * 51)
    expect(user).to_not be_valid
end
  it 'is invalid with too short first_name' do
  user = build(:user, first_name: 'a')
  expect(user).to_not be_valid
end
  it 'is invalid with too short last_name' do
    user = build(:user, last_name: 'a')
      expect(user).to_not be_valid
    end
  it 'is invalid with too short password' do
    password = 'abcde'
    user = build(:user, password: password, password_confirmation: password)
    expect(user).to_not be_valid
  end
end
  describe 'email format' do
    it 'is invalid with invalid email format' do
      invalid_emails = %w(Adam niepoprawny@email @wp.pl a@b@c a@aa.a)

      invalid_emails.each do |email|
        user = build(:user, email: email)
        expect(user).to_not be_valid
      end
    end

    it 'is valid with valid email format' do
      valid_emails = %w(jan@kowalski.pl a@bc.com a+dam@adam.pl e-ma_il@mail.us)
    valid_emails.each do |email|
      user = build(:user, email:email)
      expect(user).to be_valid
    end
  end
end
   describe 'email uniqueness' do
     it 'is invalid with duplicated email' do
       user_1 = create(:user)
       user_2 = build(:user, email: user_1.email.upcase)
       expect(user_2).to_not be_valid
    end
   end
  end
  it 'downcase email before save' do
    email = 'FOO@BAAR.com'
    user = create(:user, email: email)
    expect(user.email).to eq email.downcase
  end
end
describe 'secure password' do
  it 'is invalid when password_confirmation not match' do
    user = build(:user, password: 'password', password_confirmation: 'pass')
    expect(user).to_not be_valid
end
it 'authenticates correctly' do
  password = 'password'
  user = build(:user, password: password, password_confirmation: password)
  expect(user.authenticate('invalid')).to eq false
  expect(user.authenticate('password')).to eq user
end
end
