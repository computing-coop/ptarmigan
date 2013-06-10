# -*- encoding : utf-8 -*-
class Admin::IncomesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :exclude_guests  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  layout 'staff'
  
  def create
    create! { admin_expenses_path }
  end

  def index
    if params[:render_csv] == "1"
      @expenses = Expense.order('expenses.when DESC')
      @incomes = Income.order('incomes.when DESC')
      render_csv("incomes", "incomes")
    else
      @expenses = apply_scopes(Expense).order('expenses.when DESC').page(params[:page]).per(100)
      @incomes = apply_scopes(Income).order('incomes.when DESC').page(params[:page]).per(100)
    end
  end  
  
  def update
    update! { admin_expenses_path }
  end
  
  protected

  def render_csv(filename = nil, template = nil)
    require 'csv'
    filename ||= params[:action]
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end
    render :layout => false, :file => "#{Rails.root}/app/views/admin/incomes/#{template}.csv.erb"
  end
  
  
end
