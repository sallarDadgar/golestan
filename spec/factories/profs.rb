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

FactoryGirl.define do
  factory :prof do
    college "MyString"
    experience "MyString"
  end
end
