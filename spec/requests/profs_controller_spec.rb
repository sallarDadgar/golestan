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
            currentprof = create(:admin)
            currentuser = create(:user, role: :admin, fkey: currentprof)
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
            #   binding.pry
            #   expect(json['data'].size).to eql(1)
            expect(json['data']['id'].to_i).to eql(prof.id)
            expect(json['data']['attributes']['college']).to eql('MIT')
            expect(json['data']['attributes']['experience']).to eql('5 years')
            expect(json['data']['attributes']['user']['frst_name']).to eql('qoli')
            expect(json['data']['attributes']['user']['last_name']).to eql('qolizadeh')
            expect(json['data']['attributes']['user']['email']).to eql('qoli@gmail.com')
            expect(json['data']['attributes']['user']['role']).to eql('prof')
            expect(json['data']['attributes']['user']['fkey_id']).to eql(prof.id)
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
            expect(json['newname']).to eql('ahmad')
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
                delete "/profs/#{prof.id}", params:{
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
            expect(json['profcounted']).to eql(0)
            expect(json['usercounted']).to eql(1)
        end
    end
end
