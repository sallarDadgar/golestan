# frozen_string_literal: true

# == Schema Information
#
# Table name: projors
#
#  id         :bigint           not null, primary key
#  forek_type :string           not null
#  prof       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  forek_id   :bigint           not null
#
# Indexes
#
#  index_projors_on_forek_type_and_forek_id  (forek_type,forek_id)
#

class Projor < ApplicationRecord
  validates :prof, presence: true
  belongs_to :forek, polymorphic: true
end
