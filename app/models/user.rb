# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  code                   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fkey_type              :string           not null
#  frst_name              :string
#  last_name              :string
#  profile                :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  fkey_id                :bigint           not null
#
# Indexes
#
#  index_users_on_email                  (email) UNIQUE
#  index_users_on_fkey_type_and_fkey_id  (fkey_type,fkey_id)
#  index_users_on_reset_password_token   (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: %i(admin prof student)

  belongs_to :fkey, polymorphic: true
  validates :frst_name, presence: true
	validates :last_name, presence: true
	validates :profile, presence: true
	validates :role, presence: true
  validates :code, presence: true


  # mount_uploader :profile, AttachmentUploader

  def full_name
		"#{frst_name} #{last_name}"
	end
end
