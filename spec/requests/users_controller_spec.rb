require "rails_helper"

RSpec.describe "users controller", type: :request do
  context '.index' do
    it 'should retun failed response' do
     get '/users'
     expect(json['messages']).to eql('you are not logged in!')

    end

    it 'should retun success response' do
      user = create(:user)
      sign_in(user)
      get '/users'
      expect(json['data']).to eql(true)

     end
  end
end