require 'spec_helper'

describe UcbRails::UserSessionManager::ActiveInUserTable do
  let(:manager) { UcbRails::UserSessionManager::ActiveInUserTable.new }
  let(:user) { UcbRails::User.create!({uid: 1}, without_protection: true) }
  let(:last_user) { UcbRails::User.last! }
  
  describe "login" do

    context 'in ldap' do
      it "in User table" do
        user
        manager.login("1").should == last_user
        last_user.last_login_at.should be_within(1).of(Time.now)
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
  
  describe '#current_user' do
    it "#current_user" do
      user
      manager.current_user("1").should == user
    end
    
    it "blank" do
      [nil, ''].each do |uid|
        manager.current_user(uid).should be_nil
      end
    end
  end
  
  describe '#log_request' do
    it "#log_request" do
      manager.log_request(user)
      user.last_request_at.should be_within(1).of(Time.now)
    end
    
    it "nil" do
      expect { manager.log_request('') }.to_not raise_error
    end
  end
  
  describe '#logout' do
    it "user" do
      manager.logout(user)
      user.last_logout_at.should be_within(1).of(Time.now)
    end
    
    it "nil" do
      expect { manager.logout('') }.to_not raise_error
    end
  end
  
end