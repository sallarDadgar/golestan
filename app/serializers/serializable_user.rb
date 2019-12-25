class SerializableUser < JSONAPI::Serializable::Resource
  type 'users'

  attributes :frst_name,:profile, :last_name, :code, :role, :fkey_id, :email

  belongs_to :student
  belongs_to :prof
end
