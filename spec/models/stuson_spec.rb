# == Schema Information
#
# Table name: stusons
#
#  id         :bigint           not null, primary key
#  fk_type    :string           not null
#  lesson     :integer
#  mark       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fk_id      :bigint           not null
#
# Indexes
#
#  index_stusons_on_fk_type_and_fk_id  (fk_type,fk_id)
#

require 'rails_helper'

RSpec.describe Stuson, type: :model do
  context 'validations' do
    it "should return error when lesson not provided" do
      stud = create(:student)
      stuson = create(:stuson, fk_id: stud.id, fk_type: 'Student')
      stuson.lesson = nil
      expect(stuson).not_to be_valid
      expect(stuson.errors.messages[:lesson]).to eql(["can't be blank"])
    end
  end
end
