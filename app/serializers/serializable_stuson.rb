class SerializableStuson < JSONAPI::Serializable::Resource
  type 'students'

  attributes :mark, :lesson

  belongs_to :student
end
