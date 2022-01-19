=begin
Peter Bardon

Dapper Labs Homework Assignment

The version of the OpenAPI document: 1.0.0
Generated by: https://github.com/openapitools/openapi-generator.git

=end

class Token < ApplicationRecord
  def self.create_token(user_id)
    token = JWT.encode({ user_id: user_id }, ENV['JWT_SECRET'], 'HS256')
    Token.create(token: token)
    token
  end

  def self.valid_token?(token)
    return false unless Token.find_by_token(token)
    true
  end

  def decode
    JWT.decode(token, ENV['JWT_SECRET'], true, algorithm: 'HS256')
  end
end
