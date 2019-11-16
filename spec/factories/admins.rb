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

FactoryGirl.define do
  factory :admin do
    age "MyString"
    nationality "MyString"
  end
end
