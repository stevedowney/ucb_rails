require 'spec_helper'

describe UcbRails::UserSessionManager::UserTableActive do
  let(:manager) { UcbRails::UserSessionManager::UserTableActive.new }
  let(:user) { UcbRails::User.create!({uid: 1}, without_protection: true) }
  
  describe "login" do

    context 'in ldap' do
      it "in User table" do
        user
        manager.login("1").should == user
        user.reload.last_login_at.should be_within(1).of(Time.now)
      end
      
      it "inactive in User table" do
        user.update_attribute(:inactive, true)
        manager.login("1").should be_false
      end
      
      it "not in User table" do
        manager.login("1").should be_false
      end
    end

    context 'not in ldap' do
      it "always false" do
        user
        manager.login("100").should be_false
      end
    end
    
  end
  
end