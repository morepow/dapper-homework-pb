require 'swagger_helper'

RSpec.describe 'Users API Controller Test', type: :request do
  path '/api/v1/users' do
    get 'Lists all users' do
      tags 'Users'
      response '200', 'user list' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('yes, it worked')
        end
      end
    end

    path '/api/v1/users/{id}' do
      put 'Update a user' do
        tags 'Users'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'user updated' do
          schema type: :object,
            properties: {
              firstName: { type: :string },
              lastName: { type: :string }
            },
            required: ['firstName', 'lastName']

          let(:id) { User.create(first_name: 'foo', last_name: 'bar').id }
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
