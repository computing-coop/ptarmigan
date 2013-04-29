# -*- encoding : utf-8 -*-
class Wikifile < ActiveRecord::Base
  belongs_to :wikiattachment, :polymorphic => true
  belongs_to :expense, :polymorphic => true
  belongs_to :documenttype
  has_attached_file :attachment,
    :path =>  ":rails_root/public/wikiattachments/:id/:basename.:extension",
    :url => "/wikiattachments/:id/:basename.:extension"
  validates_attachment_presence :attachment
  # validates_presence_of :wikiattachment_id, :wikiattachment_type
  validates_presence_of :documenttype_id
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  def document_name
    if !description.blank?
      description + " / " + source_name
    else
      if wikiattachment.class == Expense
        wikiattachment.expense_name
      elsif wikiattachment.class == Income
        wikiattachment.income_name
      else
        wikiattachment.name
      end
    end
  end

  def icon
    if ["image/jpeg", "image/gif", "image/png", "image/jpg", "image/pjpeg"].include?(attachment_content_type)
      attachment
    else
      'wikifile_icon.png'
    end
  end

  def location
    if wikiattachment.class == Expense || wikiattachment.class == Income
      wikiattachment.location
    else
      nil
    end
  end

  def document_type_name
    documenttype.nil? ? 'undefined' : documenttype.name
  end

  def source_resource
    wikiattachment.class == Wikirevision ? '/admin/wiki/' + wikiattachment.name : [:admin, wikiattachment]
  end

  def source_name
    if wikiattachment.class == Expense
      wikiattachment.expense_name
    elsif wikiattachment.class == Income
      wikiattachment.income_name
    else
      wikiattachment.name
    end
  end

end