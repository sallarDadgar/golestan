# == Schema Information
#
# Table name: reshtehs
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :reshteh do
    title { FFaker::DizzleIpsum.phrase }
  end
end
