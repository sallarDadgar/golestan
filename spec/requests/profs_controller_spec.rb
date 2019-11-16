require 'rails_helper'

RSpec.describe 'profs Controller', type: :request do
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
