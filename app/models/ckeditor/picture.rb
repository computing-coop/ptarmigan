# -*- encoding : utf-8 -*-
class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data,
                    :url =>':s3_domain_url',
                    path: "ckeditor_assets/pictures/:id/:style_:basename.:extension",
	                  :styles => { :content => '800>', :thumb => '118x100#' }
	
	validates_attachment_size :data, :less_than => 5.megabytes
	validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  alias_attribute :name, :title
	def url_content
	  url(:content)
	end
end
