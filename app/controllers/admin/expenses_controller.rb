# -*- encoding : utf-8 -*-
class Admin::ExpensesController < InheritedResources::Base
  before_filter :authenticate_user!
  before_filter :exclude_guests
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json, :csv
  layout 'staff'

  has_scope :page, :default => 1
  
  has_scope :render_csv
  has_scope :by_location
  has_scope :i_location
  has_scope :by_payer
  has_scope :i_source
  has_scope :has_receipt, :type => :boolean
  has_scope :by_recipient
  has_scope :by_month
  has_scope :i_month
  has_scope :by_period, :using => [:started_at, :ended_at]
  has_scope :by_budgetarea
  has_scope :i_budgetarea
  
  def create
    create! { admin_expenses_path }
  end
  
  def update
    update! { admin_expenses_path }
  end
  
  def index
      @expenses = apply_scopes(Expense).order('expenses.when DESC').page(params[:page]).per(100)
      @incomes = apply_scopes(Income).order('incomes.when DESC').page(params[:page]).per(100)
      if params[:render_csv] == "1"
        @expenses = Expense.order('expenses.when DESC')
        @incomes = Income.order('incomes.when DESC')
        render_csv("expenses", "expenses")
      end
  end
  
  def show
    redirect_to admin_expenses_path + "#expense_" + params[:id]
  end
  protected

  def collection
    paginate_options ||= {}
    paginate_options[:page] ||= (params[:page] || 1)
    paginate_options[:per_page] ||= (params[:per_page] || 20)
    @expenses ||= end_of_association_chain.page(params[:page]).per(20)
  end

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
    render :layout => false, :file => "#{Rails.root}/app/views/admin/expenses/#{template}.csv.erb"
  end
    
  # def index
  #   @expenses = Expense.all.sort_by{|x| x.location_id }.reverse
  # end
  
end
