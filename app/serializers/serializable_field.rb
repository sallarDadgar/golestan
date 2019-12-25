class SerializableField < JSONAPI::Serializable::Resource
  type 'fields'

  attributes :title, :unit, :fkey_id, :fkey_type
  has_one :projor
  belongs_to :reshteh
end