# -*- encoding : utf-8 -*-
class Admin::ProposalcommentsController < InheritedResources::Base
  
  actions :index, :show, :new, :edit, :create, :update, :destroy
  respond_to :html, :js, :xml, :json
  before_filter :authenticate_user!
  
  def create
    create! { admin_proposal_path(@proposalcomment.proposal) }
  end
end
