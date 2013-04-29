# -*- encoding : utf-8 -*-
class Admin::ReportsController < ApplicationController
  layout 'staff'
  before_filter :authenticate_user!
  

  def check_for_icon
    unless current_user.icon?
      flash[:error] = 'Please upload a photo or image of yourself for your profile.'
      redirect_to edit_user_path(current_user)
    end
  end

  def index
    check_for_icon
    # @expenses = Expense.sum('amount')
    # @income = Income.sum('amount') 
    # # @latest = Resource.order('created_at DESC').limit(15)
    # # @latest = Wikifile.order('created_at DESC').limit(15)
    # # @latest = @latest[0..14]
    @activities = PublicActivity::Activity.all
  end

  def search
    if params[:search].blank?
      @hits = []
      @nosearch = 1
    else
      batch = ThinkingSphinx::BatchedSearch.new
      
      [Artist, Project, Event, Post, Page, Resource].each do |cat|
        batch.searches << cat.search(params[:search])
      end  
      
      @hits = batch.searches.compact.map(&:entries).flatten.compact
      batch = ThinkingSphinx::BatchedSearch.new
      [Wikifile, Wikipage, Wikirevision, Expense, Income].each do |cat|
        batch.searches << cat.search(params[:search])
      end
      @staff_hits  = batch.searches.compact.map(&:entries).flatten.compact
      @searchterm = params[:search]
    end

  end

end
