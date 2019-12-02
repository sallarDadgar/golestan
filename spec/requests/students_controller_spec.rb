# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students Controller', type: :request do
  context '.index' do
    it 'should retun success response' do
      student = create(:student, birthPlace: 'Iran', rank: '1000200')
      admin = create(:admin, age: '33', nationality: 'iran')
      user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: student)
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      stuson1 = create(:stuson, mark: '18', lesson: 1, fk_id: student.id, fk_type: 'Student')

      sign_in(user2)

      get '/students'

      expect(json['data'][0]['attributes']['birthPlace']).to eql('Iran')
      expect(json['data'][0]['attributes']['rank']).to eql('1000200')
      expect(json['included'][0]['attributes']['frst_name']).to eql('qoli')
      expect(json['included'][0]['attributes']['last_name']).to eql('qolizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('qoli@gmail.com')
      expect(json['included'][1]['attributes']['mark']).to eql('18')
      expect(json['included'][1]['attributes']['lesson']).to eql(1)




      # expect(json['data'].size).to eql(1)
      # expect(json['data'][0]['id'].to_i).to eql(student.id)
      # expect(json['data'][0]['attributes']['birthPlace']).to eql('Iran')
      # expect(json['data'][0]['attributes']['rank']).to eql('1000200')
      # expect(json['data'][0]['attributes']['user']['frst_name']).to eql('qoli')
      # expect(json['data'][0]['attributes']['user']['last_name']).to eql('qolizadeh')
      # expect(json['data'][0]['attributes']['user']['email']).to eql('qoli@gmail.com')
    end
  end

  context '.create' do
    it 'should add user' do
      currentstudent = create(:admin)
      user = create(:user, role: :admin, fkey: currentstudent)
      sign_in(user)
      student = create(:student)

      post '/students', params: {
        student: {
          birthPlace: 'iran',
          rank: '1000',
          user_attributes: {
            profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
            email: 'alizadeh@gmail.com', code: '3223234344',
            password: 'ARELSADA',
            password_confirmation: 'ARELSADA'
          },
          stusons_attributes: [
            { lesson: 2, mark: '14' },
            { lesson: 3, mark: '15' },
            { lesson: 1, mark: '20' }
          ]
        }
      }
      expect(json['data']['attributes']['birthPlace']).to eql('iran')
      expect(json['data']['attributes']['rank']).to eql('1000')
      expect(json['included'][0]['attributes']['frst_name']).to eql('ali')
      expect(json['included'][0]['attributes']['last_name']).to eql('alizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('alizadeh@gmail.com')
      expect(json['included'][0]['attributes']['code']).to eql('3223234344')
      expect(json['included'][3]['attributes']['mark']).to eql('14')
      expect(json['included'][3]['attributes']['lesson']).to eql(2)
      expect(json['included'][2]['attributes']['mark']).to eql('15')
      expect(json['included'][2]['attributes']['lesson']).to eql(3)
      expect(json['included'][1]['attributes']['mark']).to eql('20')
      expect(json['included'][1]['attributes']['lesson']).to eql(1)
    end
  end

  context '.show' do
    it 'should return specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      student = create(:student, birthPlace: 'Iran', rank: '1000200')
      user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: student)
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      stuson1 = create(:stuson, mark: '18', lesson: 1, fk_id: student.id, fk_type: 'Student')

      sign_in(user2)

      get "/students/#{student.id}"
      expect(json['data']['attributes']['birthPlace']).to eql('Iran')
      expect(json['data']['attributes']['rank']).to eql('1000200')
      expect(json['included'][0]['attributes']['frst_name']).to eql('qoli')
      expect(json['included'][0]['attributes']['last_name']).to eql('qolizadeh')
      expect(json['included'][0]['attributes']['email']).to eql('qoli@gmail.com')
      # expect(json['included'][0]['attributes']['profile']).to eql('my image')
      # expect(json['included'][0]['attributes']['code']).to eql('3223234344')
      # expect(json['included'][1]['attributes']['mark']).to eql('18')
      # expect(json['included'][1]['attributes']['lesson']).to eql(1)




      #   expect(json['data'].size).to eql(1)
      # expect(json['data']['id'].to_i).to eql(student.id)
      # expect(json['data']['attributes']['birthPlace']).to eql('Iran')
      # expect(json['data']['attributes']['rank']).to eql('1000200')
      # expect(json['data']['attributes']['user']['frst_name']).to eql('qoli')
      # expect(json['data']['attributes']['user']['last_name']).to eql('qolizadeh')
      # expect(json['data']['attributes']['user']['email']).to eql('qoli@gmail.com')
      # expect(json['data']['attributes']['user']['role']).to eql('student')
      # expect(json['data']['attributes']['user']['fkey_id']).to eql(student.id)
    end
  end

  context '.update' do
    it 'should update specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      student = create(:student, birthPlace: 'Iran', rank: '1000200')
      user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: student)
      stuson1 = create(:stuson, mark: '18', lesson: 1, fk_id: student.id, fk_type: 'Student')

      sign_in(user2)

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
      expect(json['data']['attributes']['birthPlace']).to eql('iran')
      expect(json['data']['attributes']['rank']).to eql('1000')
      expect(json['included'][0]['attributes']['frst_name']).to eql('ahmad')
      expect(json['included'][0]['attributes']['last_name']).to eql('ahmadi')
      expect(json['included'][0]['attributes']['email']).to eql('stuff@stuff.com')
      expect(json['included'][0]['attributes']['profile']).to eql('my image')
      expect(json['included'][0]['attributes']['code']).to eql('3223234344')
      expect(json['included'][1]['attributes']['mark']).to eql('18')
      expect(json['included'][1]['attributes']['lesson']).to eql(1)
    end
  end

  context '.destroy' do
    it 'should delete specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                            email: 'qoli2@gmail.com', fkey: admin)
      student = create(:student, birthPlace: 'Iran', rank: '1000200')
      user = create(:user, role: :student, frst_name: 'qoli', last_name: 'qolizadeh',
                           email: 'qoli@gmail.com', fkey: student)

      sign_in(user2)

      delete "/students/#{student.id}", params: {
        student: {
          id: student.id
          # birthPlace: 'iran',
          # rank: '1000',
          # user_attributes: {
          #   id: user.id,
          #   fkey: student,
          #   role: :student,
          #   frst_name: 'ahmad',
          #   last_name: 'ahmadi',
          #   profile: 'my image',
          #   code: '3223234344',
          #   password: 'ARELSADA',
          #   password_confirmation: 'ARELSADA',
          #   email: 'stuff@stuff.com'
          # },
          # stusons_attributes: [
          #   { lesson: 2, mark: '14' },
          #   { lesson: 3, mark: '15' },
          #   { lesson: 1, mark: '20' }
          # ]
        }
      }
      expect(json['student_destroyed']).to eql('student was destroyed')
    end
  end
end
