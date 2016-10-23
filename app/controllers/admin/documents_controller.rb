# -*- encoding : utf-8 -*-
class Admin::DocumentsController < Admin::BaseController
  layout 'staff'
  before_action :authenticate_user!

  def index
    @documents = Resource.all
    @documents += Wikifile.all
  end
  
end