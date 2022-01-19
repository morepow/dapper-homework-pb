require 'swagger_helper'

RSpec.describe 'Users API Controller Test', type: :request do
  path '/api/v1/users' do
    user = User.create(email: 'test@test.io', first_name: 'foo', last_name: 'bar', password_digest: 'foo')
    user_id = User.find_by_email('test@test.io').id
    let(:id) { user_id }
    let(Token.token_header_name.to_sym) { Token.create_token(user_id) }
    get 'Lists all users' do
      tags 'Users'
      produces 'application/json'

      parameter name: Token.token_header_name, in: :header, type: :string
      tags 'Users'
      response '200', 'user list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['users']).to be_present
          expect(data['users'][0]['email']).to be_present
          expect(data['users'][0]['firstName']).to be_present
          expect(data['users'][0]['lastName']).to be_present
        end
      end
    end


    path '/api/v1/users/{id}' do
      user = User.create(email: 'test@test.io', first_name: 'foo', last_name: 'bar', password_digest: 'foo')
      user_id = User.find_by_email('test@test.io').id
      let(:id) { user_id }
      let(Token.token_header_name.to_sym) { Token.create_token(user_id) }

      put 'Update a user' do
        tags 'Users'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :id, in: :path, type: :string
        parameter name: Token.token_header_name, in: :header, type: :string

        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            firstName: { type: :string },
            lastName: { type: :string }
          },
          required: [ 'firstName', 'lastName' ]
        }

        response '200', 'user updated' do
          let(:user) { { firstName: 'foo', content: 'bar' } }

          run_test! do |response|
            data = JSON.parse(response.body)
            expect(data['firstName']).to eq('foo')
            expect(data['lastName']).to eq('bar')
          end
        end
      end
    end
  end
end
