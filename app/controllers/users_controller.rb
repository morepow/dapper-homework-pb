=begin
Peter Bardon

Dapper Labs Homework Assignment

The version of the OpenAPI document: 1.0.0
Generated by: https://github.com/openapitools/openapi-generator.git

=end
class UsersController < ApplicationController

  def index
    # Your code here

    render json: {"message" => "yes, it worked"}
  end

  def update_user
    # Your code here
    render json: { firstName: 'foo', lastName: 'bar' }
  end
end
