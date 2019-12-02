# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profs Controller', type: :request do
  context '.index' do
    it 'should retun success response' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      prof = create(:prof, college: 'MIT', experience: '10 years')
      user = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: prof)
      sign_in(user2)
      get '/profs'
      expect(json['data'][0]['attributes']['college']).to eql('MIT')
      expect(json['data'][0]['attributes']['experience']).to eql('10 years')
      expect(json['included'][0]['attributes']['frst_name']).to eql('qoli')
      expect(json['included'][0]['attributes']['last_name']).to eql('qolizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('qoli@gmail.com')
      expect(json['included'][0]['attributes']['role']).to eql('prof')

      # expect(json['data'].size).to eql(1)
      # expect(json['data'][0]['id'].to_i).to eql(prof.id)
      # expect(json['data'][0]['attributes']['college']).to eql('MIT')
      # expect(json['data'][0]['attributes']['experience']).to eql('10 years')
      # expect(json['data'][0]['attributes']['user']['frst_name']).to eql('qoli')
      # expect(json['data'][0]['attributes']['user']['last_name']).to eql('qolizadeh')
      # expect(json['data'][0]['attributes']['user']['email']).to eql('qoli@gmail.com')
    end
  end

  context '.create' do
    it 'should add user' do
      currentprof = create(:admin)
      currentuser = create(:user, role: :admin, fkey: currentprof)
      sign_in(currentuser)
      prof = create(:prof)
      post '/profs', params: {
        prof: {
          college: 'MIT', experience: '10 years',
          user_attributes: {
            profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
            email: 'alizadeh@gmail.com', code: '3223234344',
            password: 'ARELSADA',
            password_confirmation: 'ARELSADA'
          }
        }
      }
      expect(json['data']['attributes']['college']).to eql('MIT')
      expect(json['data']['attributes']['experience']).to eql('10 years')
      expect(json['included'][0]['attributes']['frst_name']).to eql('ali')
      expect(json['included'][0]['attributes']['last_name']).to eql('alizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('alizadeh@gmail.com')
      expect(json['included'][0]['attributes']['code']).to eql('3223234344')
    end
  end

  context '.show' do
    it 'should return specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      prof = create(:prof, college: 'MIT', experience: '5 years')
      user = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: prof)
      sign_in(user2)
      get "/profs/#{prof.id}"
      #   expect(json['data'].size).to eql(1)
      expect(json['data']['id'].to_i).to eql(prof.id)
      expect(json['data']['attributes']['college']).to eql('MIT')
      expect(json['data']['attributes']['experience']).to eql('5 years')
      expect(json['included'][0]['attributes']['frst_name']).to eql('qoli')
      expect(json['included'][0]['attributes']['last_name']).to eql('qolizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('qoli@gmail.com')
    end
  end

  context '.update' do
    it 'should update specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      prof = create(:prof, college: 'MIT', experience: '5 years')
      user = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: prof)

      sign_in(user2)

      patch "/profs/#{prof.id}", params: {
        prof: {
          id: prof.id,
          college: 'MIT',
          experience: '5 years',
          user_attributes: {
            id: user.id,
            fkey: prof,
            role: :prof,
            frst_name: 'ahmad',
            last_name: 'ahmadi',
            profile: 'my image',
            code: '3223234344',
            password: 'ARELSADA',
            password_confirmation: 'ARELSADA',
            email: 'stuff@stuff.com'
          }
        }
      }
      expect(json['data']['attributes']['college']).to eql('MIT')
      expect(json['data']['attributes']['experience']).to eql('5 years')
      expect(json['included'][0]['attributes']['frst_name']).to eql('ahmad')
      expect(json['included'][0]['attributes']['last_name']).to eql('ahmadi')
      expect(json['included'][0]['attributes']['email']).to eql('stuff@stuff.com')
      expect(json['included'][0]['attributes']['profile']).to eql('my image')
      expect(json['included'][0]['attributes']['code']).to eql('3223234344')
    end
  end

  context '.destroy' do
    it 'should delete specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      prof = create(:prof, college: 'MIT', experience: '5 years')
      user = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: prof)

      sign_in(user2)
      delete "/profs/#{prof.id}", params: {
        prof: {
          id: prof.id,
        #   college: 'MIT',
        #   experience: '5 years',
        #   user_attributes: {
        #     id: user.id,
        #     fkey: prof,
        #     role: :prof,
        #     frst_name: 'ahmad',
        #     last_name: 'ahmadi',
        #     profile: 'my image',
        #     code: '3223234344',
        #     password: 'ARELSADA',
        #     password_confirmation: 'ARELSADA',
        #     email: 'stuff@stuff.com'
        #   }
        }
      }
      expect(json['prof_destroyed']).to eql('prof was destroyed')
    end
  end
end
