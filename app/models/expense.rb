# -*- encoding : utf-8 -*-
class Expense < ActiveRecord::Base
  belongs_to :event
  has_many :wikifiles, :dependent => :destroy, :as => :wikiattachment
  accepts_nested_attributes_for :wikifiles, :allow_destroy => true #, :reject_if => proc { |t| t['attachment'].blank?  }
  belongs_to :location
  belongs_to :budgetarea
  validates_presence_of :location_id, :amount, :when, :recipient, :what_for
  resourcify
  # scope :i_month
  # scope :i_location
  # scope :i_budgetarea
  # scope :i_event
  # scope :i_source
  scope :by_location, -> (location) { where(location_id: location) }
  scope :by_recipient, -> (recipient) { where(recipeient: recipient) }
  scope :by_month, -> (month) { where(["expenses.when >= ? AND expenses.when <= ?", 
      Date.new(*(Date.parse(month).strftime('%Y %m') + " 1").split.map{|x| x.to_i }),
     Date.new(*(Date.parse(month).strftime('%Y %m') + " -1").split.map{|x| x.to_i }) ] )}
  scope :by_year, ->(year)  { where(["expenses.when >= ? AND expenses.when <= ?", 
    Date.parse(year + "-01-01").to_s,
    Date.parse(year + "-12-31").to_s] )}    
  scope :by_budgetarea, -> (budgetarea)  { where(budgetarea_id: budgetarea) }
  scope :by_event, ->(event) { where(event_id: event)}
  scope :by_payer, -> (payer) { where(paid_by: payer)}
  scope :has_receipt, ->() {where(has_receipt: true) }

  FILTERS = [
              {:scope => "all", :label => "All"},
              {:scope => "by_location", :label => "Which Ptarmigan?"},
              {:scope => 'by_recipient', :label => "Recipient"},
              {:scope => 'by_month', :label => "Month"},
              {:scope => "by_budgetarea", :label => "Budget area"},
              {:scope => "by_event", :label => "Event"},
              {:scope => "by_year", :label => 'Year'},
              {:scope => "by_payer", :label => "Paid by"},
              {:scope => "has_receipt", :label => "Has receipt?"}
    ]
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
      
  def name
    expense_name
  end
  
  def expense_name
    what_for + " / " + recipient + " [#{self.when.strftime('%d %B %Y')}]"
  end
   
  def icon
    'expense_icon.png' 
  end
  
end
