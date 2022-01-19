require 'swagger_helper'

RSpec.describe 'Signup API Controller Test', type: :request do
  path '/api/v1/signup' do
    post 'Creates a user' do
      tags 'Signup'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          firstName: { type: :string },
          lastName: { type: :string }
        },
        required: ['email', 'password', 'firstName', 'lastName']
      }

      response '200', 'user updated' do
        let(:user) { { email: 'test@test.io', password: 'mockpassword', firstName: 'Foo', lastName: 'Bar' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['token']).to be_present
        end
      end

      response '400', 'invalid request' do
        let(:user) { { email: 'test@test.io' } }
        run_test!
      end
    end
  end
end
