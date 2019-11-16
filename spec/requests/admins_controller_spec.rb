require 'rails_helper'

RSpec.describe 'Admins Controller', type: :request do
    context '.create' do
        it 'should add user' do
            currentadmin = create(:admin)
            currentuser = create(:user, fkey: currentadmin)
            sign_in(currentuser)
            admin = create(:admin)
            post '/admins', params: {
                admin:{
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
end
