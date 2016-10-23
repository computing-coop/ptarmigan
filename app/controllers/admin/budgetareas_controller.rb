# -*- encoding : utf-8 -*-
class Admin::BudgetareasController < Admin::BaseController
  before_action :authenticate_user!

  respond_to :html, :js, :xml, :json
  layout 'staff'
  has_scope :page, :default => 1
  load_and_authorize_resource
  
  def create
    create! { admin_budgetareas_path }
  end
  
  def update
    update! { admin_budgetareas_path }
  end
  protected


    
  # def index
  #   @budgetareas = Budgetarea.all.sort_by{|x| x.location_id }.reverse
  # end
  
end
