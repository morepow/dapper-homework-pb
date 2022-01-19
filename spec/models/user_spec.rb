require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should be able to authenticate a user' do
    email = "testauth#{SecureRandom.urlsafe_base64(3)}@test.io"
    password = SecureRandom.urlsafe_base64(10)
    User.create({
                  email: email,
                  password: password,
                  first_name: 'foo',
                  last_name: 'bar'
                })
    expect(User.authenticate({ email: email, password: password })).to_not be false
  end

  it 'should be able to create a user with a password' do
    email = "testauth#{SecureRandom.urlsafe_base64(3)}@test.io"
    password = SecureRandom.urlsafe_base64(10)
    token_str = User.create_with_password({
                                            email: email,
                                            password: password,
                                            firstName: 'foo',
                                            lastName: 'bar'
                                          })
    user_id = User.find_by_email(email).id
    token = Token.find_by_token(token_str)
    expect(token.decode[0]['user_id']).to eq(user_id)
  end

  it 'should be able to validate a user token' do
    email = "testauth#{SecureRandom.urlsafe_base64(3)}@test.io"
    password = SecureRandom.urlsafe_base64(10)
    token_str = User.create_with_password({
                                            email: email,
                                            password: password,
                                            firstName: 'foo',
                                            lastName: 'bar'
                                          })
    user = User.find_by_email(email)

    expect(user.valid_user_token?(token_str)).to be true
  end
end
