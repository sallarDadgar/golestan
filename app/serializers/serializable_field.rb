class SerializableField < JSONAPI::Serializable::Resource
  type 'fields'

  attributes :title, :unit
end