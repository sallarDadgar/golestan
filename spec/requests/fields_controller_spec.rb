require 'rails_helper'

RSpec.describe 'fields Controller', type: :request do
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
      sign_in(user2)
      get '/fields'

      expect(json['data'][0]['attributes']['title']).to eql('math1')
      expect(json['data'][0]['attributes']['unit']).to eql('3')
      expect(json['included'][0]['attributes']['prof']).to eql(prof.id)
      expect(json['included'][0]['attributes']['forek_id']).to eql(field1.id)
      expect(json['included'][0]['attributes']['forek_type']).to eql('Field')

      # expect(json['data'].size).to eql(1)
      # expect(json['data'][0]['id'].to_i).to eql(field1.id)
      # expect(json['data'][0]['attributes']['title']).to eql('math1')
      # expect(json['data'][0]['attributes']['unit']).to eql('3')
    end
  end
  context '.create' do
    it 'should add lesson' do
        currentprof = create(:admin)
        currentuser = create(:user, role: :admin, fkey: currentprof)
        prof = create(:prof)
        sign_in(currentuser)
        reshteh1 = create(:reshteh, title: 'math')
        post '/fields', params: {
          field:{
            title: 'math1',
            unit: '3',
            fkey_type: 'Reshteh',
            fkey_id: reshteh1.id,
            projor_attributes: {
              prof: prof.id
            }
          }
        }
        field1_id = json['data']['id']
        # binding.pry
        expect(json['data']['attributes']['title']).to eql('math1')
        expect(json['data']['attributes']['unit']).to eql('3')
        expect(json['included'][0]['attributes']['prof']).to eql(prof.id)
        expect(json['included'][0]['attributes']['forek_id']).to eql(field1_id.to_i)
        expect(json['included'][0]['attributes']['forek_type']).to eql('Field')
    end
  end

  context '.show' do
    it 'should return specified field' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
          email: 'qoli2@gmail.com', fkey: admin)
      prof = create(:prof)
      user3 = create(:user, role: :prof, frst_name: 'ali', last_name: 'alizadeh',
        email: 'qoli3@gmail.com', fkey: prof)
      reshteh1 = create(:reshteh, title: 'math')
      field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
      projor1 = create(:projor, prof: prof.id, forek: field1)
      sign_in(user2)
      get "/fields/#{field1.id}"

      expect(json['data']['attributes']['title']).to eql('math1')
      expect(json['data']['attributes']['unit']).to eql('3')
      expect(json['included'][0]['attributes']['prof']).to eql(prof.id)
      expect(json['included'][0]['attributes']['forek_id']).to eql(field1.id)
      expect(json['included'][0]['attributes']['forek_type']).to eql('Field')


      # expect(json['data']['id'].to_i).to eql(field1.id)
      # expect(json['data']['attributes']['title']).to eql('math1')
      # expect(json['data']['attributes']['unit']).to eql('3')
    end
  end

  context '.update' do
    it 'should update specified field' do
          admin = create(:admin, age: '33', nationality: 'iran')
          user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
              email: 'qoli2@gmail.com', fkey: admin)
          prof = create(:prof)
          user3 = create(:user, role: :prof, frst_name: 'ali', last_name: 'alizadeh',
            email: 'qoli3@gmail.com', fkey: prof)
          reshteh1 = create(:reshteh, title: 'math')
          field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
          projor1 = create(:projor, prof: prof.id, forek: field1)
          sign_in(user2)
          patch "/fields/#{field1.id}", params: {
            field: {
                  id: field1.id,
                  title: 'math2',
                  unit: '4'
              }
            }
          expect(json['data']['attributes']['title']).to eql('math2')
          expect(json['data']['attributes']['unit']).to eql('4')
          expect(json['included'][0]['attributes']['prof']).to eql(prof.id)
          expect(json['included'][0]['attributes']['forek_id']).to eql(field1.id)
          expect(json['included'][0]['attributes']['forek_type']).to eql('Field')



          # expect(json['newtitle']).to eql('math2')
    end
  end

  context '.destroy' do
    it 'should delete specified lesson' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        prof = create(:prof)
        user3 = create(:user, role: :prof, frst_name: 'ali', last_name: 'alizadeh',
          email: 'qoli3@gmail.com', fkey: prof)
        reshteh1 = create(:reshteh, title: 'math')
        field1 = create(:field, title: 'math1', unit: '3', fkey: reshteh1)
        projor1 = create(:projor, prof: prof.id, forek: field1)
        sign_in(user2)
            delete "/fields/#{field1.id}", params:{
                field: {
                    id: field1.id
                }
            }
        expect(json['field_destroyed']).to eql('field was destroyed')
    end
  end
end