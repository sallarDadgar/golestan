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
  has_one :user, as: :fkey, dependent: :destroy
  has_many :stusons, as: :fk, dependent: :destroy

  validates :birthPlace, presence: true
  validates :rank, presence: true

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :stusons
end
