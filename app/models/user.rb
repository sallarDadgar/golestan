# frozen_string_literal: true

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

class User < ApplicationRecord
  enum role: %i(admin prof student)

  validates :frst_name, presence: true
	# validates :last_name, presence: true
	# validates :image, presence: true
	# validates :role, presence: true
  # validates :email, uniqueness: true


	# validates :code, presence: true

  def full_name
		"#{frst_name} #{last_name}"
	end
end
