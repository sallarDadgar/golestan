class SerializableStudent < JSONAPI::Serializable::Resource
  type 'students'

  attributes :birthPlace, :rank
  has_one :user
  has_many :stusons




  # class Meta
  #   model = Student
  #   fields = ['birthPlace', 'rank', 'user']
  # end
end
