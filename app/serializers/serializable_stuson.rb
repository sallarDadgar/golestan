class SerializableStuson < JSONAPI::Serializable::Resource
  type 'students'

  attributes :mark, :lesson
end
