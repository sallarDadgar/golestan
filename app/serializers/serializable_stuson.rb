class SerializableStuson < JSONAPI::Serializable::Resource
  type 'students'

  attributes :id, :mark, :lesson, :fk_id, :fk_type

  belongs_to :student
end
