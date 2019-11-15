# frozen_string_literal: true

class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :frst_name, :last_name, :code, :role, :created_at, :updated_at, :email
end
