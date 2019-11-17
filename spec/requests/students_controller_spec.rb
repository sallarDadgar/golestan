require 'rails_helper'

RSpec.describe 'Students Controller', type: :request do
    context '.index' do
        it 'should retun success response' do
          student = create(:student, birthPlace: 'Iran', rank: '1000200')
          user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                               email: 'qoli@gmail.com', fkey: student)
          sign_in(user)
          get '/students'
        #   binding.pry
          expect(json['data'].size).to eql(1)
          expect(json['data'][0]['id'].to_i).to eql(student.id)
          expect(json['data'][0]['attributes']['birthPlace']).to eql('Iran')
          expect(json['data'][0]['attributes']['rank']).to eql('1000200')
          expect(json['data'][0]['attributes']['user']['frst_name']).to eql('qoli')
          expect(json['data'][0]['attributes']['user']['last_name']).to eql('qolizadeh')
          expect(json['data'][0]['attributes']['user']['email']).to eql('qoli@gmail.com')
        end
    end

    context '.create' do
        it 'should add user' do
            currentstudent = create(:student)
            currentuser = create(:user, fkey: currentstudent)
            sign_in(currentuser)
            student = create(:student)
            post '/students', params: {
                student:{
                    birthPlace: 'iran', rank: '1000',
                    user_attributes: {
                        profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
                        email: 'alizadeh@gmail.com', code: '3223234344',
                        password: 'ARELSADA',
                        password_confirmation: 'ARELSADA'
                    }
                }
            }
            expect(json['studentSaved']).to eql(true)
        end
    end
end
