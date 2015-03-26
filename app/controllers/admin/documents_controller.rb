# -*- encoding : utf-8 -*-
class Admin::DocumentsController < InheritedResources::Base
  layout 'staff'
  before_filter :authenticate_user!

  def index
    @documents = Resource.all
    @documents += Wikifile.all
  end
  
end