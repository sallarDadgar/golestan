# == Schema Information
#
# Table name: students
#
#  id         :bigint           not null, primary key
#  birthPlace :string
#  rank       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :student do
    birthPlace { FFaker::DizzleIpsum.phrase }
    rank { FFaker::AddressGR.street_nbr }.to_s
  end
end
