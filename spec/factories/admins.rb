# frozen_string_literal: true

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
    age { FFaker::AddressGR.street_nbr }.to_s
    nationality { FFaker::DizzleIpsum.phrase }
  end
end
