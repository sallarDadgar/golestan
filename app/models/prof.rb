# == Schema Information
#
# Table name: profs
#
#  id         :bigint           not null, primary key
#  college    :string
#  experience :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Prof < ApplicationRecord
  has_one :user, as: :fkey, dependent: :destroy
  validates :college, presence: true
  validates :experience, presence: true

  accepts_nested_attributes_for :user
end
