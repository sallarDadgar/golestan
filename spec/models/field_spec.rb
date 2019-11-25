# == Schema Information
#
# Table name: fields
#
#  id         :bigint           not null, primary key
#  title      :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Field, type: :model do
  context 'validations' do
    it "should return error when title not provided" do
      field = create(:field)
      field.title = ''
      expect(field).not_to be_valid
      expect(field.errors.messages[:title]).to eql(["can't be blank"])
    end

    it "should return error when unit not provided" do
      field = create(:field)
      field.unit = ''
      expect(field).not_to be_valid
      expect(field.errors.messages[:unit]).to eql(["can't be blank"])
    end
  end
end
