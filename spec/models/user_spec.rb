# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  code       :string
#  email      :string
#  frst_name  :string
#  last_name  :string
#  profile    :string
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
