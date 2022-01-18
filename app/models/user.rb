=begin
Peter Bardon

Dapper Labs Homework Assignment

The version of the OpenAPI document: 1.0.0
Generated by: https://github.com/openapitools/openapi-generator.git

=end


class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password_digest, presence: true

  has_many :tokens, dependent: :destroy

  def self.authenticate(params)
    user = User.find_by(email: params[:email])
    digest = BCrypt::Password.new(user.password)
    if user && user.password_digest == digest
      Token.create_token(user.id)
    end
  end

  def self.create_with_password(params)
    user = User.new(params)
    user.password_digest = BCrypt::Password.create(params[:password])
    user.save
    Token.create_token(user.id)
  end

  def valid_user_token?(token)
    token = Token.find_by(token: token)
    if token.user_id == self.id
      true
    else
      false
    end
  end
end
