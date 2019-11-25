class SerializableStudent < JSONAPI::Serializable::Resource
  type 'students'

  attributes :birthPlace, :rank, :user, :stusons
end
