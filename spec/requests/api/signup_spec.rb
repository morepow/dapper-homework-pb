require 'swagger_helper'

RSpec.describe 'Signup API Controller Test', type: :request do
  path '/signup' do
    post 'Creates a user' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'firstName', 'lastName']
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
