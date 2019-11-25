# == Schema Information
#
# Table name: fields
#
#  id         :bigint           not null, primary key
#  fkey_type  :string           not null
#  title      :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fkey_id    :bigint           not null
#
# Indexes
#
#  index_fields_on_fkey_type_and_fkey_id  (fkey_type,fkey_id)
#

require 'rails_helper'

RSpec.describe Field, type: :model do
  context 'validations' do
    it "should return error when title not provided" do
      reshteh1 = create(:reshteh, title: 'math')
      field = create(:field, fkey: reshteh1)
      field.title = ''
      expect(field).not_to be_valid
      expect(field.errors.messages[:title]).to eql(["can't be blank"])
    end

    it "should return error when unit not provided" do
      reshteh1 = create(:reshteh, title: 'math')
      field = create(:field, fkey: reshteh1)
      field.unit = ''
      expect(field).not_to be_valid
      expect(field.errors.messages[:unit]).to eql(["can't be blank"])
    end
  end
end
