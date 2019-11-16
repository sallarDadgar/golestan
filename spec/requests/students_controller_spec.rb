require 'rails_helper'

RSpec.describe 'Students Controller', type: :request do
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
