# == Schema Information
#
# Table name: stusons
#
#  id         :bigint           not null, primary key
#  fk_type    :string           not null
#  lesson     :integer
#  mark       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fk_id      :bigint           not null
#
# Indexes
#
#  index_stusons_on_fk_type_and_fk_id  (fk_type,fk_id)
#

FactoryGirl.define do
  factory :stuson do
    lesson { FFaker::AddressGR.street_nbr }
    mark { FFaker::AddressGR.street_nbr }.to_s
  end
end
