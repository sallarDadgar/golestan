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

class Admin < ApplicationRecord
  validates :age, presence: true
  validates :nationality, presence: true
end
