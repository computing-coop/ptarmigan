# -*- encoding : utf-8 -*-

# encoding: utf-8

class ProposalsController < ApplicationController
  
  def axis_of_praxis
    set_meta_tags :open_graph => {
      :title => "Axis of Praxis application form | Ptarmigan" ,
      :type  => "ptarmigan:proposal",
      :url   =>  url_for({:only_path => false, :controller => :proposals, :action => :axis_of_praxis})
      },
      :canonical =>  url_for({:only_path => false, :controller => :proposals, :action => :axis_of_praxis}),
      :keywords => 'Tallinn,Estonia,Mooste,MoKS,Ptarmigan,proposals,application,residency,culture,art,trans-disciplinary,urban,rural,Kulturkontakt Nord',
      :description => 'Application form for the Axis of Praxis residency programme, which offers the possibility to research and develop work in and between two distinctly different contexts within Estonia, both in Tallinn (Ptarmigan) and Mooste (MoKS).',
      :title => 'Axis of Praxis proposal form' 
    Formtastic::FormBuilder.priority_countries = ["Åland Islands", "Denmark", "Faroe Islands", "Finland", "Iceland", "Greenland", "Latvia", "Lithuania",  "Norway", "Sweden"]      
    @proposal = Proposal.new(:project_id => 35)
  end

  def create
    @proposal = Proposal.new(params[:proposal])
    if verify_recaptcha(:model => @proposal, :message => "Incorrenct CAPTCHA!") && @proposal.save 
      redirect_to '/proposals/thank_you'
    else
      render :template => 'proposals/new'
    end
  end
  
  def new
    set_meta_tags :open_graph => {
      :title => "Proposals | Ptarmigan" ,
      :type  => "ptarmigan:proposal",
      :url   =>  url_for({:only_path => false, :controller => :proposals, :action => :new})
      },
      :canonical =>  url_for({:only_path => false, :controller => :proposals, :action => :new}),
      :keywords => 'Helsinki,Finland,Tallinn,Estonia,Ptarmigan,proposals,application,residency,culture,art',
      :description => 'Ptarmigan is a project space that relies on ideas from you for it’s programming! With this form you can submit your ideas to Ptarmigan. These ideas can be anything from a one-off artist talk or performance to a long-duration residency. Please fill in the required information and we’ll get back to you as soon as we can.',
      :title => t(:proposals)
    Formtastic::FormBuilder.priority_countries = ["Åland Islands", "Denmark", "Estonia", "Faroe Islands", "Finland", "Iceland", "Greenland", "Latvia", "Lithuania",  "Norway", "Sweden"]      
    @proposal = Proposal.new
  end
  
  def index
    redirect_to '/proposals/new'
  end
  
  def thank_you
  end

end
