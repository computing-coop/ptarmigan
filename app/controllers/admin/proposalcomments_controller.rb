# -*- encoding : utf-8 -*-
class Admin::ProposalcommentsController < Admin::BaseController
  load_and_authorize_resource

  respond_to :html, :js, :xml, :json
  before_action :authenticate_user!
  
  def create
    create! { admin_proposal_path(@proposalcomment.proposal) }
  end
end
