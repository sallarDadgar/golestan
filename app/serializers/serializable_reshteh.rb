class SerializableReshteh < JSONAPI::Serializable::Resource
  type 'reshtehs'

  attributes :title
  has_many :fields
end
