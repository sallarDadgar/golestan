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

require 'rails_helper'

RSpec.describe Field, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
