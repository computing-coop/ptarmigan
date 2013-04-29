# -*- encoding : utf-8 -*-
class Admin::ProposalsController < InheritedResources::Base
  
  before_filter :authenticate_user!
  before_filter :find_proposal

  layout 'staff'
  EVENTS_PER_PAGE = 20
  
  private

  def find_proposal
    @proposal = Proposal.find(params[:id]) if params[:id]
  end
end
