# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  code                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fkey_type              :string           not null
#  frst_name              :string
#  last_name              :string
#  profile                :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  fkey_id                :bigint           not null
#
# Indexes
#
#  index_users_on_email                  (email) UNIQUE
#  index_users_on_fkey_type_and_fkey_id  (fkey_type,fkey_id)
#  index_users_on_reset_password_token   (reset_password_token) UNIQUE
#

FactoryGirl.define do
  factory :user do
    frst_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email FFaker::Internet.email
    password { 'ARELSADA' }
    code { FFaker::AddressGR.street_nbr }.to_s
    role { %i[admin prof student].sample }
    # File.open('somewhere') do |f|
    #   profile = f
    # end
    profile 'app/assets/images/play1.jpeg'
  end
end
