class SerializableAdmin < JSONAPI::Serializable::Resource
  type 'admins'

  attributes :age, :nationality, :user
end
