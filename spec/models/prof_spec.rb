# == Schema Information
#
# Table name: profs
#
#  id         :bigint           not null, primary key
#  college    :string
#  experience :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Prof, type: :model do
  context 'validations' do
    it "should return error when college not provided" do
      prof = create(:prof)
      prof.college = ''
      expect(prof).not_to be_valid
      expect(prof.errors.messages[:college]).to eql(["can't be blank"])
    end

    it "should return error when nationality not provided" do
      prof = create(:prof)
      prof.experience = ''
      expect(prof).not_to be_valid
      expect(prof.errors.messages[:experience]).to eql(["can't be blank"])
    end
  end
end
