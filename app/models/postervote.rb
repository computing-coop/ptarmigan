class Postervote < ActiveRecord::Base
  belongs_to :place
  validates_presence_of :ip_address, :vote, :place_id
  attr_accessible :comment, :contact_email, :ip_address, :vote, :place
end
