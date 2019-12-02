class SerializableField < JSONAPI::Serializable::Resource
  type 'fields'

  attributes :title, :unit
  has_one :projor
  belongs_to :reshteh
end