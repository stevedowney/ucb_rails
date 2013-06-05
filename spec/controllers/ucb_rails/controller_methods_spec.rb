require 'spec_helper'

describe UcbRails::ControllerMethods do
  let(:controller) { ApplicationController.new }
  
  describe '#logged_in?' do
    it "true" do
      controller.stub(current_user: mock('user'))
      controller.should be_logged_in
    end
    
    it "false" do
      controller.stub(session: {uid: ''})
      controller.should_not be_logged_in
    end
  end
  
  describe '#current_ldap_person' do
    it "logged in" do
      # ldap_person = mock('ldap_person')
      # controller.stub(logged_in?: true)
      # UCB::LDAP::Person.should_receive(:find_by_uid).with('123').and_return(ldap_person)
      # controller.current_ldap_person.should == ldap_person
    end
    
    it "not logged in" do
      controller.stub(session: {uid: ''})
      UCB::LDAP::Person.should_not_receive(:find_by_uid)
      controller.current_ldap_person.should be_nil
    end
  end
  
end