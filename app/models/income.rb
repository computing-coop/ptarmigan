# -*- encoding : utf-8 -*-
class Income < ActiveRecord::Base
  belongs_to :event
  has_many :wikifiles, :dependent => :destroy, :as => :wikiattachment
  accepts_nested_attributes_for :wikifiles, :allow_destroy => true #, :reject_if => proc { |t| t['attachment'].blank?  }
  belongs_to :location
  belongs_to :budgetarea
  validates_presence_of :location_id, :amount, :when, :source, :what_for
      
  # scope :by_location
  # scope :by_recipient
  # scope :by_month
  # scope :by_payer
  # scope :by_budgetarea
  scope :i_location, -> (location) { where(location_id: location)}
  scope :i_month, -> (month) { where(["incomes.when >= ? AND incomes.when <= ?", 
      Date.new(*(Date.parse(month).strftime('%Y %m') + " 1").split.map{|x| x.to_i }),
     Date.new(*(Date.parse(month).strftime('%Y %m') + " -1").split.map{|x| x.to_i })])}

  scope :by_year, ->(year) {where(["incomes.when >= ? AND incomes.when <= ?", 
    Date.parse(year + "-01-01").to_s,
    Date.parse(year + "-12-31").to_s])}

  scope :i_budgetarea,->(budgetarea) { where(budgetarea_id: budgetarea)}
  scope :i_event, ->(event) { where(event_id: event)}
  scope :i_source, ->(payer) { where(source: payer)}

 
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
      
  def name
    income_name
  end
  
  def income_name
    what_for + " / " + source + " [#{self.when.strftime('%d %B %Y')}]"
  end

  def icon
    'income_icon.png' 
  end  
end
