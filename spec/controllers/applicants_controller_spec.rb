# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'
  
# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe ApplicantsController do
  fixtures :applicants

  it 'allows signup' do
    lambda do
      create_applicant
      response.should be_redirect
    end.should change(Applicant, :count).by(1)
  end

  

  it 'signs up user with activation code' do
    create_applicant
    assigns(:applicant).reload
    assigns(:applicant).activation_code.should_not be_nil
  end
  it 'requires login on signup' do
    lambda do
      create_applicant(:login => nil)
      assigns[:applicant].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(Applicant, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_applicant(:password => nil)
      assigns[:applicant].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(Applicant, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_applicant(:password_confirmation => nil)
      assigns[:applicant].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(Applicant, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_applicant(:email => nil)
      assigns[:applicant].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(Applicant, :count)
  end
  
  
  it 'activates user' do
    Applicant.authenticate('aaron', 'monkey').should be_nil
    get :activate, :activation_code => applicants(:aaron).activation_code
    response.should redirect_to('/login')
    flash[:notice].should_not be_nil
    flash[:error ].should     be_nil
    Applicant.authenticate('aaron', 'monkey').should == applicants(:aaron)
  end
  
  it 'does not activate user without key' do
    get :activate
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with blank key' do
    get :activate, :activation_code => ''
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  it 'does not activate user with bogus key' do
    get :activate, :activation_code => 'i_haxxor_joo'
    flash[:notice].should     be_nil
    flash[:error ].should_not be_nil
  end
  
  def create_applicant(options = {})
    post :create, :applicant => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
end

describe ApplicantsController do
  describe "route generation" do
    it "should route applicants's 'index' action correctly" do
      route_for(:controller => 'applicants', :action => 'index').should == "/applicants"
    end
    
    it "should route applicants's 'new' action correctly" do
      route_for(:controller => 'applicants', :action => 'new').should == "/signup"
    end
    
    it "should route {:controller => 'applicants', :action => 'create'} correctly" do
      route_for(:controller => 'applicants', :action => 'create').should == "/register"
    end
    
    it "should route applicants's 'show' action correctly" do
      route_for(:controller => 'applicants', :action => 'show', :id => '1').should == "/applicants/1"
    end
    
    it "should route applicants's 'edit' action correctly" do
      route_for(:controller => 'applicants', :action => 'edit', :id => '1').should == "/applicants/1/edit"
    end
    
    it "should route applicants's 'update' action correctly" do
      route_for(:controller => 'applicants', :action => 'update', :id => '1').should == "/applicants/1"
    end
    
    it "should route applicants's 'destroy' action correctly" do
      route_for(:controller => 'applicants', :action => 'destroy', :id => '1').should == "/applicants/1"
    end
  end
  
  describe "route recognition" do
    it "should generate params for applicants's index action from GET /applicants" do
      params_from(:get, '/applicants').should == {:controller => 'applicants', :action => 'index'}
      params_from(:get, '/applicants.xml').should == {:controller => 'applicants', :action => 'index', :format => 'xml'}
      params_from(:get, '/applicants.json').should == {:controller => 'applicants', :action => 'index', :format => 'json'}
    end
    
    it "should generate params for applicants's new action from GET /applicants" do
      params_from(:get, '/applicants/new').should == {:controller => 'applicants', :action => 'new'}
      params_from(:get, '/applicants/new.xml').should == {:controller => 'applicants', :action => 'new', :format => 'xml'}
      params_from(:get, '/applicants/new.json').should == {:controller => 'applicants', :action => 'new', :format => 'json'}
    end
    
    it "should generate params for applicants's create action from POST /applicants" do
      params_from(:post, '/applicants').should == {:controller => 'applicants', :action => 'create'}
      params_from(:post, '/applicants.xml').should == {:controller => 'applicants', :action => 'create', :format => 'xml'}
      params_from(:post, '/applicants.json').should == {:controller => 'applicants', :action => 'create', :format => 'json'}
    end
    
    it "should generate params for applicants's show action from GET /applicants/1" do
      params_from(:get , '/applicants/1').should == {:controller => 'applicants', :action => 'show', :id => '1'}
      params_from(:get , '/applicants/1.xml').should == {:controller => 'applicants', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/applicants/1.json').should == {:controller => 'applicants', :action => 'show', :id => '1', :format => 'json'}
    end
    
    it "should generate params for applicants's edit action from GET /applicants/1/edit" do
      params_from(:get , '/applicants/1/edit').should == {:controller => 'applicants', :action => 'edit', :id => '1'}
    end
    
    it "should generate params {:controller => 'applicants', :action => update', :id => '1'} from PUT /applicants/1" do
      params_from(:put , '/applicants/1').should == {:controller => 'applicants', :action => 'update', :id => '1'}
      params_from(:put , '/applicants/1.xml').should == {:controller => 'applicants', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/applicants/1.json').should == {:controller => 'applicants', :action => 'update', :id => '1', :format => 'json'}
    end
    
    it "should generate params for applicants's destroy action from DELETE /applicants/1" do
      params_from(:delete, '/applicants/1').should == {:controller => 'applicants', :action => 'destroy', :id => '1'}
      params_from(:delete, '/applicants/1.xml').should == {:controller => 'applicants', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/applicants/1.json').should == {:controller => 'applicants', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end
  
  describe "named routing" do
    before(:each) do
      get :new
    end
    
    it "should route applicants_path() to /applicants" do
      applicants_path().should == "/applicants"
      formatted_applicants_path(:format => 'xml').should == "/applicants.xml"
      formatted_applicants_path(:format => 'json').should == "/applicants.json"
    end
    
    it "should route new_applicant_path() to /applicants/new" do
      new_applicant_path().should == "/applicants/new"
      formatted_new_applicant_path(:format => 'xml').should == "/applicants/new.xml"
      formatted_new_applicant_path(:format => 'json').should == "/applicants/new.json"
    end
    
    it "should route applicant_(:id => '1') to /applicants/1" do
      applicant_path(:id => '1').should == "/applicants/1"
      formatted_applicant_path(:id => '1', :format => 'xml').should == "/applicants/1.xml"
      formatted_applicant_path(:id => '1', :format => 'json').should == "/applicants/1.json"
    end
    
    it "should route edit_applicant_path(:id => '1') to /applicants/1/edit" do
      edit_applicant_path(:id => '1').should == "/applicants/1/edit"
    end
  end
  
end
