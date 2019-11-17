class SerializableStudent < JSONAPI::Serializable::Resource
  type 'students'

  attributes :birthPlace, :rank, :user
end
