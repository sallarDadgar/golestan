require "rails_helper"

RSpec.describe "stusons controller", type: :request do
  context '.update' do
    it 'should update specified user' do
      admin = create(:admin, age: '33', nationality: 'iran')
      user2 = create(:user, role: :admin, frst_name: 'qoli', last_name: 'qolizadeh',
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
      expect(json['newmark']).to eql('18')
    end
  end
end