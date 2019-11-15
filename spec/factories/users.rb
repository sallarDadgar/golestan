# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  code                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  frst_name              :string
#  last_name              :string
#  profile                :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user do
    frst_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email FFaker::Internet.email
    password { 'ARELSADA '}
    code "MyString"
    role { %i(admin prof student).sample}
    profile "MyString"
  end
end
