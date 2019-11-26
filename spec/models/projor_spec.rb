# == Schema Information
#
# Table name: projors
#
#  id         :bigint           not null, primary key
#  forek_type :string           not null
#  prof       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  forek_id   :bigint           not null
#
# Indexes
#
#  index_projors_on_forek_type_and_forek_id  (forek_type,forek_id)
#

require 'rails_helper'

RSpec.describe Projor, type: :model do
  context 'validations' do
    it "should return error when prof not provided" do
      reshteh1 = create(:reshteh)
      field1 = create(:field, fkey: reshteh1)
      projor = create(:projor, forek: field1)
      projor.prof = nil
      expect(projor).not_to be_valid
      expect(projor.errors.messages[:prof]).to eql(["can't be blank"])
    end
  end
end
