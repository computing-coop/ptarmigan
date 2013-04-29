# -*- encoding : utf-8 -*-
class Airform < ActiveRecord::Base
  
  belongs_to :applicant
  
  has_attached_file :cv
  has_attached_file :attachment
  
  after_save :send_submitted_email
  
  def send_submitted_email
    ApplicantMailer.deliver_submitted_application(self.applicant) if self.submitted == true
  end
  
  def can_edit?
    !submitted
  end
  
  
  def completed
    completed = 0
    [self.project_summary, self.detailed_description, self.events, self.equipment, self.budget].each do |w|
      unless w.empty?
        completed += 1
      end
    end
    unless self.dates.blank?
      completed += 1
    end
    
    unless self.cv_file_size.nil?
      completed += 1
    end
    
    unless self.attachment_file_size.nil?
      completed += 1
    end
    
    unless self.terms_agreed.blank?
      completed += 1
    end
    return (( completed.to_f / 9 ) * 100).to_i.to_s + '%'
  end
  
  def dates
    out = ''
    if self.jul_aug == true
      out += 'July/August<br />'
    end
    if self.sept_oct == true
      out += 'September/October<br />'
    end
    if self.nov_dec == true
      out += 'November/December<br />'
    end
    return out
  end
  
  def show_answer(field)
    if self[field].blank?
      '<b>Not answered</b>'
    else
      self[field]
    end
  end
    
end
