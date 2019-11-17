# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admins Controller', type: :request do
  context '.index' do
    it 'should retun success response' do
      admin = create(:admin, age: '27', nationality: 'IR')
      user = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: admin)
      sign_in(user)
      get '/admins'
    #   binding.pry
      expect(json['data'].size).to eql(1)
      expect(json['data'][0]['id'].to_i).to eql(admin.id)
      expect(json['data'][0]['attributes']['age']).to eql('27')
      expect(json['data'][0]['attributes']['nationality']).to eql('IR')
      expect(json['data'][0]['attributes']['user']['frst_name']).to eql('qoli')
      expect(json['data'][0]['attributes']['user']['last_name']).to eql('qolizadeh')
      expect(json['data'][0]['attributes']['user']['email']).to eql('qoli@gmail.com')
    end
  end

  context '.create' do
    it 'should add user' do
      currentadmin = create(:admin)
      currentuser = create(:user, fkey: currentadmin)
      sign_in(currentuser)
      admin = create(:admin)
      post '/admins', params: {
        admin: {
          age: '35', nationality: 'IR',
          user_attributes: {
            profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
            email: 'alizadeh@gmail.com', code: '3223234344',
            password: 'ARELSADA',
            password_confirmation: 'ARELSADA'
          }
        }
      }
      expect(json['adminSaved']).to eql(true)
    end
  end

  # context '.show' do
  #   it 'should return specified user' do
  #   end
  # end
end
