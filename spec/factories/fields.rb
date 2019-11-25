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

FactoryGirl.define do
  factory :field do
    title "MyString"
    unit "MyString"
  end
end
