class SerializableProf < JSONAPI::Serializable::Resource
  type 'profs'

  attributes :college, :experience, :user
end
