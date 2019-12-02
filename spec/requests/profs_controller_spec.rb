# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'profs Controller', type: :request do
  context 'valid params' do
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
  context 'invalid params' do
    context '.create' do
      it 'should not add prof when no college provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: '', experience: '10 years',
            user_attributes: {
              profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['college']).to eql(["can't be blank"])
      end
      it 'should not add prof when no experience provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '',
            user_attributes: {
              profile: 'my image', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['experience']).to eql(["can't be blank"])
      end
      it 'should not add prof when no profile provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: '', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.profile']).to eql(["can't be blank"])
      end
      it 'should not add prof when no first name provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: '', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.frst_name']).to eql(["can't be blank"])
      end
      it 'should not add prof when no last name provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: '',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.last_name']).to eql(["can't be blank"])
      end
      it 'should not add prof when no email provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: 'alizadeh',
              email: '', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.email']).to eql(["can't be blank"])
      end
      it 'should not add prof when no valid email provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadehgmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.email']).to eql(["is invalid"])
      end
      it 'should not add prof when no code provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.code']).to eql(["can't be blank"])
      end
      it 'should not add prof when no password provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: '',
              password_confirmation: 'ARELSADA'
            }
          }
        }
        expect(json['user.password']).to eql(["can't be blank"])
      end
      it 'should not add prof when no password_confirmation provided' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        prof = create(:prof)
        post '/profs', params: {
          prof: {
            college: 'MIT', experience: '10 years',
            user_attributes: {
              profile: 'my immage', frst_name: 'ali', last_name: 'alizadeh',
              email: 'alizadeh@gmail.com', code: '3223234344',
              password: 'ARELSADA',
              password_confirmation: 'ARELSADAN'
            }
          }
        }
        expect(json['user.password_confirmation']).to eql(["doesn't match Password"])
      end
    end
    context '.update' do
      it 'should not update prof when invalid attrinutes provided' do
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
            college: '',
            experience: '',
            user_attributes: {
              id: user.id,
              fkey: prof,
              role: :prof,
              frst_name: '',
              last_name: '',
              profile: '',
              code: '',
              password: '',
              password_confirmation: '',
              email: ''
            }
          }
        }
        expect(json['college']).to eql(["can't be blank"])
        expect(json['experience']).to eql(["can't be blank"])
        expect(json['user.frst_name']).to eql(["can't be blank"])
        expect(json['user.last_name']).to eql(["can't be blank"])
        expect(json['user.profile']).to eql(["can't be blank"])
        expect(json['user.code']).to eql(["can't be blank"])
        expect(json['user.password']).to eql(["can't be blank"])
        expect(json['user.email']).to eql(["can't be blank"])
      end
      it 'should not update prof when password_confirmation does not match' do
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
              password_confirmation: 'ARELSADAN',
              email: 'stuff@stuff.com'
            }
          }
        }
        expect(json['user.password_confirmation']).to eql(["doesn't match Password"])
      end
      it 'should not update prof when email is not valid' do
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
              email: 'stuffstuff.com'
            }
          }
        }
        expect(json['user.email']).to eql(["is invalid"])
      end
    end
  end
end
