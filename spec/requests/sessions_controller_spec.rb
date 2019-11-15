require "rails_helper"

RSpec.describe "sessions controller", type: :request do
  context '.create' do
    it 'should retun failed response' do
      post '/users/sign_in', params: {}
      expect(json['success']).to eql(false)
      expect(json['errors']).to eql(['Login failed.'])

    end

    it 'should retun success response' do
      create(:user, email: 'qoli@gmail.com', password: 'ARELSADA')
      post '/users/sign_in', params: {
        user: {
          email: 'qoli@gmail.com',
          password: 'ARELSADA'
        }
      }
      expect(json['success']).to eql(true)
    end
  end
  context '.destroy' do
    # it 'should retun failed response' do
    #   user = create(:user, email: 'qoli@gmail.com', password: 'ARELSADA')
    #   sign_in(user)
    #   delete "/users/sign_out"
    #   expect(json['logout']).to eql(false)

    # end

    it 'should retun success response' do
      # user = create(:user, email: 'qoli@gmail.com', password: 'ARELSADA')
      # sign_in(user)
      delete "/users/sign_out"
      expect(json['logout']).to eql(true)
    end
  end
end