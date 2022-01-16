require 'swagger_helper'

RSpec.describe 'api/login', type: :request do
  path '/login' do
    post 'Creates a session' do
      tags 'Login'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }

      response '201', 'user updated' do
        let(:user) { { email: 'test@test.io', password: 'mockpassword' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'test@test.io' } }
        run_test!
      end
    end
  end
end
