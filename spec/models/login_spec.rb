require 'rails_helper'

RSpec.describe Login, type: :model do
  it 'should validate the presence of email' do
    login = Login.create
    expect(login.save).to be false
    login = Login.create({ email: 'test@test.io'})
    expect(login.save).to be true
    expect(login.created_at).to be_present
    expect(login.updated_at).to be_present
  end
end
