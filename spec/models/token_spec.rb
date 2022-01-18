require 'rails_helper'

RSpec.describe Token, type: :model do

  it 'should be able to generate a JWT token' do
    user = User.create(email: 'testuser@test.io', password_digest: 'mockpassworddigest', first_name: 'foo', last_name: 'bar')
    token = Token.create_token(user.id)
    expect(token).to be_present
    decoded_token = JWT.decode token, ENV['JWT_SECRET'], true, { algorithm: 'HS256' }
    expect(decoded_token[0]['user_id']).to eq(user.id)
  end
end
