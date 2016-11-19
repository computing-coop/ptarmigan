# class InstanceSerializer < ActiveModel::Serializer
#   attributes :id
#   belongs_to :event
#   class EventSerializer < ActiveModel::Serializer
#     attributes :notes, :description
#     has_many :eventcategories
#     belongs_to :place
#   end
# end
