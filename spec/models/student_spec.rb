# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  birthPlace :string
#  rank       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Student, type: :model do
  context 'validations' do
    it "should return error when birth place not provided" do
      stud = create(:student)
      stud.birthPlace = ''
      expect(stud).not_to be_valid
      expect(stud.errors.messages[:birthPlace]).to eql(["can't be blank"])
    end

    it "should return error when nationality not provided" do
      stud = create(:student)
      stud.rank = ''
      expect(stud).not_to be_valid
      expect(stud.errors.messages[:rank]).to eql(["can't be blank"])
    end
  end
end
