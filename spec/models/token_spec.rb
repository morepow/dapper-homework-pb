require 'rails_helper'

RSpec.describe Token, type: :model do
  it 'should be able to generate a JWT token' do
    user = User.create(email: 'testuser@test.io', password_digest: 'mockpassworddigest', first_name: 'foo', last_name: 'bar')
    token = Token.create_token(user.id)
    expect(token).to be_present
    decoded_token = JWT.decode token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }
    expect(decoded_token[0]['user_id']).to eq(user.id)
  end

  it 'should be able to validate a token' do
    expect(Token.valid_token?('invalidtoken')).to be false
    token = Token.create_token(99)
    expect(Token.valid_token?(token)).to be true
  end

  it 'should decode a token' do
    token_str = Token.create_token(101)
    token = Token.find_by_token(token_str)
    expect(token.decode[0]['user_id']).to eq(101)
  end
end
