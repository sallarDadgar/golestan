require "rails_helper"

RSpec.describe "users controller", type: :request do
  context '.index' do
    it 'should retun failed response' do
     get '/users'
     expect(json['messages']).to eql('you are not logged in!')

    end

    it 'should retun success response' do
      user = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
      email: 'qoli@gmail.com')
      sign_in(user)
      get '/users'
      expect(json['data'].size).to eql(1)
      expect(json['data'][0]['id'].to_i).to eql(user.id)
      expect(json['data'][0]['attributes']['frst_name']).to eql('qoli')
      expect(json['data'][0]['attributes']['last_name']).to eql('qolizadeh')
      expect(json['data'][0]['attributes']['email']).to eql('qoli@gmail.com')
     end
  end
end