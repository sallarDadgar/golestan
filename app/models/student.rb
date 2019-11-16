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

class Student < ApplicationRecord
  validates :birthPlace, presence: true
  validates :rank, presence: true
end
