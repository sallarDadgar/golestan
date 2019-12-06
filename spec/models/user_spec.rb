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

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'EnumRations' do
    it { is_expected.to respond_to :admin? }
    it { is_expected.to respond_to :prof? }
    it { is_expected.to respond_to :student? }
  end

  describe 'methods' do
    context '.full_name' do
      it 'should return full name' do
        admin = create(:admin)
        user = create(:user, frst_name: 'ahmad', last_name: 'ahmadi', fkey: admin)
        expect(user.full_name).to eql('ahmad ahmadi')
      end
    end
  end

  context 'validations' do
    it 'should validate first name' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.frst_name = ''
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:frst_name]).to eql(["can't be blank"])
    end

    it 'should validate last name' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.last_name = ''
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:last_name]).to eql(["can't be blank"])
    end

    it 'should validate email' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.email = ''
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:email]).to eql(["can't be blank"])
    end

    it 'should validate profile' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.profile = ''
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:profile]).to eql(["can't be blank"])
    end

    it 'should validate code' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.code = ''
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:code]).to eql(["can't be blank"])
    end

    it 'should validate role' do
      admin = create(:admin)
      user = create(:user, fkey: admin)
      user.role = nil
      expect(user.valid?).to eql(false)
      expect(user.errors.messages[:role]).to eql(["can't be blank"])
    end
  end
end
