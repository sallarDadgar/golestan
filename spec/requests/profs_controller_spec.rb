require 'rails_helper'

RSpec.describe 'profs Controller', type: :request do
    context '.index' do
        it 'should retun success response' do
          prof = create(:prof, college: 'MIT', experience: '10 years')
          user = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
                               email: 'qoli@gmail.com', fkey: prof)
          sign_in(user)
          get '/profs'
        #   binding.pry
          expect(json['data'].size).to eql(1)
          expect(json['data'][0]['id'].to_i).to eql(prof.id)
          expect(json['data'][0]['attributes']['college']).to eql('MIT')
          expect(json['data'][0]['attributes']['experience']).to eql('10 years')
          expect(json['data'][0]['attributes']['user']['frst_name']).to eql('qoli')
          expect(json['data'][0]['attributes']['user']['last_name']).to eql('qolizadeh')
          expect(json['data'][0]['attributes']['user']['email']).to eql('qoli@gmail.com')
        end
    end

    context '.create' do
        it 'should add user' do
            currentprof = create(:prof)
            currentuser = create(:user, fkey: currentprof)
            sign_in(currentuser)
            prof = create(:prof)
            post '/profs', params: {
              prof:{
                    college: 'MIT', experience: '10 years',
                    user_attributes: {
                        profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
                        email: 'alizadeh@gmail.com', code: '3223234344',
                        password: 'ARELSADA',
                        password_confirmation: 'ARELSADA'
                    }
                }
            }
            expect(json['profSaved']).to eql(true)
        end
    end
end
