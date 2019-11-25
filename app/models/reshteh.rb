# == Schema Information
#
# Table name: reshtehs
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Reshteh < ApplicationRecord
  validates :title, presence: true
  has_many :fields, as: :fkey
end
