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
    frst_name "MyString"
    last_name "MyString"
    email "MyString"
    code "MyString"
    role 1
    profile "MyString"
  end
end
