# # -*- encoding : utf-8 -*-
# class ApplicantObserver < ActiveRecord::Observer
#   def after_create(applicant)
#     ApplicantMailer.deliver_signup_notification(applicant)
#   end
#
#   def after_save(applicant)
#
#     ApplicantMailer.deliver_activation(applicant) if applicant.recently_activated?
#
#   end
# end
