# -*- encoding : utf-8 -*-
class Wikirevision < ActiveRecord::Base
  belongs_to :user
  belongs_to :wikipage
  attr_accessor :menuize
  has_many :wikifiles, :dependent => :destroy, :as => :wikiattachment
  accepts_nested_attributes_for :wikifiles, :allow_destroy => true, :reject_if => proc { |t| t['attachment'].blank? || !t['id'].blank? }
  
  after_save :set_menuize
  
  def set_menuize
    wikipage.menuize = self.menuize
    wikipage.save!
  end
  
  def contents_linked
    if self.parsed_contents =~ /\<table/
      self.parsed_contents.gsub(/\[\[([\w\-\s]*)\]\]/, '<a href="/admin/wiki/\1">\1</a>').gsub(/(.*)\r\n\r\n/, '<p>\1</p>')
    else
      self.parsed_contents.gsub(/\[\[([\w\-\s]*)\]\]/, '<a href="/admin/wiki/\1">\1</a>') #.gsub(/(.*)\r\n\r\n/, '<p>\1</p>')
    end
  end
    

  def parsed_contents
    contents = self.contents.gsub(/\n{2,}/, "<br /><br />").gsub(/(\w*_\w*)/) {|match| "<a href='#{match.downcase}'>#{match.gsub('_', ' ')}</a>"}
  end

  def name
    wikipage.title
  end


end
