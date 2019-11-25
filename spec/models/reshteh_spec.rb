# == Schema Information
#
# Table name: reshtehs
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Reshteh, type: :model do
  context 'validations' do
    it "should return error when title not provided" do
      reshteh = create(:reshteh)
      reshteh.title = ''
      expect(reshteh).not_to be_valid
      expect(reshteh.errors.messages[:title]).to eql(["can't be blank"])
    end
  end
end
