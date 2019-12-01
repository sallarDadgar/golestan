# frozen_string_literal: true

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
  include Fkey
  has_one :user, as: :fkey
  validates :age, presence: true
  validates :nationality, presence: true

  accepts_nested_attributes_for :user
end
