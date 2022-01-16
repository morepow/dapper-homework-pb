require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    get 'Lists all users' do
    end

    put 'Update a user' do
    end
  end
end
