# -*- encoding : utf-8 -*-
class ApplicantMailer < ActionMailer::Base
  def signup_notification(applicant)
    setup_email(applicant)
    @subject    += 'Please activate your new account'
  
    @body[:url]  = "http://ptarmigan.fi/air/activate/#{applicant.activation_code}"
  
  end
  
  def activation(applicant)
    setup_email(applicant)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://ptarmigan.fi/air/"
  end
  
  def submitted_application(applicant)
    setup_email(applicant)
    @cc = "air@ptarmigan.fi"
    @bcc = "board@ptarmigan.fi"
    @subject = "[Ptarmigan] Application submitted for residency!"
  end

  protected
    def setup_email(applicant)
      @recipients  = "#{applicant.login}"
      @from        = "air@ptarmigan.fi"
      @subject     = "[Ptarmigan] "
      @sent_on     = Time.now
      @body[:applicant] = applicant
    end
end
