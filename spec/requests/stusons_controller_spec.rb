require "rails_helper"

RSpec.describe "stusons controller", type: :request do
  context 'valid params' do
    context '.create' do
      it 'should add stuson' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        sign_in(user2)
        student = create(:student)
        post '/stusons', params: {
          stuson: {
            mark: '18',
            lesson: 1,
            fk_id: student.id,
            fk_type: 'Student'
          }
        }
        expect(json['data']['attributes']['lesson']).to eql(1)
        expect(json['data']['attributes']['mark']).to eql('18')
        expect(json['data']['attributes']['fk_id']).to eql(student.id)
        expect(json['data']['attributes']['fk_type']).to eql('Student')
      end
    end

    context '.update' do
      it 'should update specified user' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        sign_in(user2)
        student = create(:student)
        stuson = create(:stuson, lesson: 1, fk: student)
        patch "/stusons/#{stuson.id}", params: {
          stuson: {
            id: stuson.id,
            mark: '18'
          }
        }
        expect(json['data']['attributes']['lesson']).to eql(1)
        expect(json['data']['attributes']['mark']).to eql('18')
      end
    end
    context '.delete' do
      it 'should delete secific stuson' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        sign_in(user2)
        student = create(:student)
        stuson = create(:stuson, lesson: 1, fk: student)
        delete "/stusons/#{stuson.id}"
        expect(json["stuson_destroyed"]).to eql("stuson was destroyed")
      end
    end
  end
  context 'invalid params' do
    context '.create' do
      it 'should not add stuson when no valid attributes provided' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        sign_in(user2)
        student = create(:student)
        post '/stusons', params: {
          stuson: {
            mark: '',
            lesson: nil,
            fk_id: nil,
            fk_type: ''
          }
        }
        expect(json['lesson']).to eql(["can't be blank"])
        expect(json['fk']).to eql(["must exist"])
      end
    end
    context '.update' do
      it 'should not update when invalid attributes provided' do
        admin = create(:admin, age: '33', nationality: 'iran')
        user2 = create(:user, role: :prof, frst_name: 'qoli', last_name: 'qolizadeh',
            email: 'qoli2@gmail.com', fkey: admin)
        sign_in(user2)
        student = create(:student)
        stuson = create(:stuson, lesson: 1, fk: student)
        patch "/stusons/#{stuson.id}", params: {
          stuson: {
            id: stuson.id,
            mark: '18',
            lesson: nil,
            fk_id: nil,
            fk_type: ''
          }
        }
        expect(json['lesson']).to eql(["can't be blank"])
        expect(json['fk']).to eql(["must exist"])
      end
    end
  end
end