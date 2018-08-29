class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :drawings
end
