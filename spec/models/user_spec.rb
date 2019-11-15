# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  code       :string
#  email      :string
#  frst_name  :string
#  last_name  :string
#  profile    :string
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context "EnumRations" do
    it { is_expected.to respond_to :admin? }
    it { is_expected.to respond_to :prof? }
    it { is_expected.to respond_to :student? }
  end

  describe 'methods' do
    context '.full_name' do
      it 'should return full name' do
        user = create(:user, frst_name: 'ahmad', last_name: 'ahmadi')
        expect(user.full_name).to eql('ahmad ahmadi')
      end
    end
  end


  describe 'validations' do
    context 'first name' do
      it 'should validate first name' do
        user = create(:user)
        user.frst_name = ''
        expect(user.valid?).to eql(false)
        expect(user.errors.messages[:frst_name]).to eql(["can't be blank"])
      end
    end
  end
end
