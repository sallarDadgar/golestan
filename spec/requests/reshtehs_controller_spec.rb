# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'reshtehs Controller', type: :request do
  context 'valid params' do
    context '.index' do
      it 'should retun success response' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                              email: 'qoli2@gmail.com', fkey: admin)
        prof = create(:prof)
        user3 = create(:user, role: :prof, frst_name: 'ali', last_name: 'alizadeh',
                              email: 'qoli3@gmail.com', fkey: prof)
        reshteh1 = create(:reshteh, title: 'math')
        field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        projor1 = create(:projor, prof: prof.id, forek: field1)
        # field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        # filed2 = create(:field, title: 'math2', unit: '4', fkey: reshteh1)
        sign_in(user2)
        get '/reshtehs'
        expect(json['data'][0]['attributes']['title']).to eql('math')
        expect(json['included'][0]['attributes']['title']).to eql('math1')
        expect(json['included'][0]['attributes']['unit']).to eql('3')
        expect(json['included'][1]['attributes']['prof']).to eql(prof.id)

        # expect(json['data'].size).to eql(1)
        # expect(json['data'][0]['id'].to_i).to eql(reshteh1.id)
        # expect(json['data'][0]['attributes']['title']).to eql('math')
      end
    end

    context '.create' do
      it 'should add reshteh' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)

        # prof = create(:prof)
        # user3 = create(:user, role: :prof, frst_name: 'ali', last_name: 'alizadeh',
        #   email: 'qoli3@gmail.com', fkey: prof)

        # reshteh1 = create(:reshteh, title: 'math')
        # field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        # projor1 = create(:projor, prof: prof.id, forek: field1)

        sign_in(currentuser)
        post '/reshtehs', params: {
          reshteh: {
            title: 'math',
            fields_attributes: [
              {
                title: 'math1', unit: '3'
              }
            ]
          }
        }
        # post '/reshtehs', params: {
        #   reshteh:{
        #     title: 'math'
        #   }
        # }
        # binding.pry
        expect(json['data']['attributes']['title']).to eql('math')
        expect(json['included'][0]['attributes']['title']).to eql('math1')
        expect(json['included'][0]['attributes']['unit']).to eql('3')
      end
    end
    context '.show' do
      it 'should return specified reshteh' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                              email: 'qoli2@gmail.com', fkey: admin)
        reshteh1 = create(:reshteh, title: 'math')
        field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        sign_in(user2)
        get "/reshtehs/#{reshteh1.id}"

        expect(json['data']['id'].to_i).to eql(reshteh1.id)
        expect(json['data']['attributes']['title']).to eql('math')
        expect(json['included'][0]['attributes']['title']).to eql('math1')
        expect(json['included'][0]['attributes']['unit']).to eql('3')
      end
    end

    context '.update' do
      it 'should update specified reshteh' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                              email: 'qoli2@gmail.com', fkey: admin)
        reshteh1 = create(:reshteh, title: 'math')
        field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        sign_in(user2)
        patch "/reshtehs/#{reshteh1.id}", params: {
          reshteh: {
            id: reshteh1.id,
            title: 'science'
          }
        }
        expect(json['data']['id'].to_i).to eql(reshteh1.id)
        expect(json['data']['attributes']['title']).to eql('science')
        expect(json['included'][0]['attributes']['title']).to eql('math1')
        expect(json['included'][0]['attributes']['unit']).to eql('3')
      end
    end

    context '.destroy' do
      it 'should delete specified reshteh' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                              email: 'qoli2@gmail.com', fkey: admin)
        reshteh1 = create(:reshteh)
        sign_in(user2)
        delete "/reshtehs/#{reshteh1.id}", params: {
          reshteh: {
            id: reshteh1.id
          }
        }
        expect(json['reshteh_destroyed']).to eql('reshteh was destroyed')
      end
    end
  end
  context 'invalid params' do
    context '.create' do
      it 'should add reshteh' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        sign_in(currentuser)
        post '/reshtehs', params: {
          reshteh: {
            title: '',
            fields_attributes: [
              {
                title: '', unit: ''
              }
            ]
          }
        }
        expect(json['title']).to eql(["can't be blank"])
        expect(json['fields.title']).to eql(["can't be blank"])
        expect(json['fields.unit']).to eql(["can't be blank"])
      end
    end
    context '.update' do
      it 'should update specified reshteh' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
                              email: 'qoli2@gmail.com', fkey: admin)
        reshteh1 = create(:reshteh, title: 'math')
        field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        sign_in(user2)
        patch "/reshtehs/#{reshteh1.id}", params: {
          reshteh: {
            id: reshteh1.id,
            title: '',
            fields_attributes: [
              {
                title: '', unit: ''
              }
            ]
          }
        }
        expect(json['title']).to eql(["can't be blank"])
        expect(json['fields.title']).to eql(["can't be blank"])
        expect(json['fields.unit']).to eql(["can't be blank"])
      end
    end
  end
end
