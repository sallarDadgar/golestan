# == Schema Information
#
# Table name: stusons
#
#  id         :bigint           not null, primary key
#  fk_type    :string           not null
#  lesson     :integer
#  mark       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fk_id      :bigint           not null
#
# Indexes
#
#  index_stusons_on_fk_type_and_fk_id  (fk_type,fk_id)
#

class Stuson < ApplicationRecord
  belongs_to :fk, polymorphic: true
  validates :lesson, presence: true
end
