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
                    birthPlace: 'iran',
                    rank: '1000',
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

    context '.show' do
        it 'should return specified user' do
            student = create(:student, birthPlace: 'Iran', rank: '1000200')
          user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                               email: 'qoli@gmail.com', fkey: student)
          sign_in(user)
          get "/students/#{student.id}"
        #   binding.pry
        #   expect(json['data'].size).to eql(1)
          expect(json['data']['id'].to_i).to eql(student.id)
          expect(json['data']['attributes']['birthPlace']).to eql('Iran')
          expect(json['data']['attributes']['rank']).to eql('1000200')
          expect(json['data']['attributes']['user']['frst_name']).to eql('qoli')
          expect(json['data']['attributes']['user']['last_name']).to eql('qolizadeh')
          expect(json['data']['attributes']['user']['email']).to eql('qoli@gmail.com')
          expect(json['data']['attributes']['user']['role']).to eql('student')
          expect(json['data']['attributes']['user']['fkey_id']).to eql(student.id)
        end
    end

    context '.update' do
        it 'should update specified user' do
            student = create(:student, birthPlace: 'Iran', rank: '1000200')
            user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                                email: 'qoli@gmail.com', fkey: student)

            sign_in(user)

            patch "/students/#{student.id}", params: {
                student: {
                    id: student.id,
                    birthPlace: 'iran',
                    rank: '1000',
                    user_attributes: {
                        id: user.id,
                        fkey: student,
                        role: :student,
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
            expect(json['newname']).to eql('ahmad')
        end
    end
end
