class SerializableProjor < JSONAPI::Serializable::Resource
  type 'projors'

  attributes :id, :prof, :forek_id, :forek_type
  belongs_to :field
end
