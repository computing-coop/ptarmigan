# -*- encoding : utf-8 -*-
class Admin::BudgetareasController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  layout 'staff'
  has_scope :page, :default => 1
  
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
