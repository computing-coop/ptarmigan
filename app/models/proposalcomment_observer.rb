# -*- encoding : utf-8 -*-
class ProposalcommentObserver < ActiveRecord::Observer
  def after_create(comment)
    ProposalcommentMailer.deliver_comment_notification(comment) unless (comment.comment =~ /\<span/ || comment.comment.blank?)
  end


end
