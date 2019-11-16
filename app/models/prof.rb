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
  validates :college, presence: true
  validates :experience, presence: true
end
