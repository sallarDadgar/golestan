class SerializableReshteh < JSONAPI::Serializable::Resource
  type 'reshtehs'

  attributes :title, :fields
end
