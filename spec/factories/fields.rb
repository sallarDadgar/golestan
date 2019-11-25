# == Schema Information
#
# Table name: fields
#
#  id         :bigint           not null, primary key
#  fkey_type  :string           not null
#  title      :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fkey_id    :bigint           not null
#
# Indexes
#
#  index_fields_on_fkey_type_and_fkey_id  (fkey_type,fkey_id)
#

FactoryGirl.define do
  factory :field do
    title "MyString"
    unit "MyString"
  end
end
