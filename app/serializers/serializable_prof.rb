class SerializableProf < JSONAPI::Serializable::Resource
  type 'profs'

  attributes :college, :experience
  has_one :user
end
