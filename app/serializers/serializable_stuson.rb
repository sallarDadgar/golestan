class SerializableStuson < JSONAPI::Serializable::Resource
  type 'students'

  attributes :mark, :lesson, :fk_id, :fk_type

  belongs_to :student
end
