# == Schema Information
#
# Table name: fields
#
#  id         :bigint           not null, primary key
#  title      :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Field < ApplicationRecord
  validates :title, presence: true
  validates :unit, presence: true
end
