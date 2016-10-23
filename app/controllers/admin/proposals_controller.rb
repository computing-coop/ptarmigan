# -*- encoding : utf-8 -*-
class Admin::ProposalsController < Admin::BaseController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :find_proposal

  layout 'staff'
  EVENTS_PER_PAGE = 20
  
  private

  def find_proposal
    @proposal = Proposal.find(params[:id]) if params[:id]
  end
end
