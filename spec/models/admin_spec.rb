# == Schema Information
#
# Table name: admins
#
#  id          :bigint           not null, primary key
#  age         :string
#  nationality :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validations' do
    it "should return error when age not provided" do
      admin = create(:admin)
      admin.age = ''
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:age]).to eql(["can't be blank"])
    end

    it "should return error when nationality not provided" do
      admin = create(:admin)
      admin.nationality = ''
      expect(admin).not_to be_valid
      expect(admin.errors.messages[:nationality]).to eql(["can't be blank"])
    end
  end
end
