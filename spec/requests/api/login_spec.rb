require 'swagger_helper'

RSpec.describe '/login', type: :request do
  path '/api/v1/login' do
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

      response '200', 'user logged in' do
        let(:user) { { email: 'test@test.io', password: 'mockpassword' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to be_present
          expect(data['message']).to eq('yes, it worked')
        end
      end

      response '400', 'invalid request' do
        let(:user) { { email: 'foo@test.io' } }
        run_test!
      end
    end
  end
end
