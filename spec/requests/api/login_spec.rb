require 'swagger_helper'

RSpec.describe 'Login API Controller Tests', type: :request do
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
        User.create({email: 'testauth@test.io', password: 'mockpassword', first_name: 'Foo', last_name: 'Bar'})
        let(:user) { { email: 'testauth@test.io', password: 'mockpassword' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['token']).to be_present
        end
      end

      response '401', 'invalid password' do
        User.create({email: 'testauth@test.io', password: 'mockpassword', first_name: 'Foo', last_name: 'Bar'})
        let(:user) { { email: 'testauth@test.io', password: 'badpassword' } }
        run_test!
      end

      response '400', 'invalid request' do
        let(:user) { { email: 'foo@test.io' } }
        run_test!
      end
    end
  end
end
