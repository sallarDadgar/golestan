# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  code       :string
#  email      :string
#  frst_name  :string
#  last_name  :string
#  profile    :string
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :user do
    frst_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email "MyString"
    code "MyString"
    role { %i(admin prof student).sample}
    profile "MyString"
  end
end
