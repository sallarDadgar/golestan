require 'rails_helper'

RSpec.describe 'reshtehs Controller', type: :request do
  context '.index' do
    it 'should retun success response' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
          email: 'qoli2@gmail.com', fkey: admin)
      reshteh1 = create(:reshteh, title: 'math')
      # field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
      # filed2 = create(:field, title: 'math2', unit: '4', fkey: reshteh1)
      sign_in(user2)
      get '/reshtehs'
      expect(json['data'].size).to eql(1)
      expect(json['data'][0]['id'].to_i).to eql(reshteh1.id)
      expect(json['data'][0]['attributes']['title']).to eql('math')
    end
  end

  context '.create' do
    it 'should add reshteh' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        post '/reshtehs', params: {
          reshteh:{
            title: 'math'
          }
        }
        expect(json['reshtehSaved']).to eql(true)
    end
  end
  context '.show' do
    it 'should return specified reshteh' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
          email: 'qoli2@gmail.com', fkey: admin)
      reshteh1 = create(:reshteh, title: 'math')
      sign_in(user2)
      get "/reshtehs/#{reshteh1.id}"
      expect(json['data']['id'].to_i).to eql(reshteh1.id)
      expect(json['data']['attributes']['title']).to eql('math')
    end
  end

  context '.update' do
    it 'should update specified reshteh' do
          admin = create(:admin, age: '33', nationality: 'iran')
          user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
              email: 'qoli2@gmail.com', fkey: admin)
          reshteh1 = create(:reshteh, title: 'math')
          sign_in(user2)
          patch "/reshtehs/#{reshteh1.id}", params: {
              reshteh: {
                  id: reshteh1.id,
                  title: 'science'
              }
            }
          expect(json['newtitle']).to eql('science')
    end
  end

  context '.destroy' do
    it 'should delete specified reshteh' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        reshteh1 = create(:reshteh)
        sign_in(user2)
            delete "/reshtehs/#{reshteh1.id}", params:{
                reshteh: {
                    id: reshteh1.id
                }
            }
        expect(json['reshtehcounted']).to eql(0)
    end
  end
end