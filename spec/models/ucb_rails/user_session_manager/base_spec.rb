require 'spec_helper'

describe UcbRails::UserSessionManager::Base do
  let(:manager) { UcbRails::UserSessionManager::Base.new }
  let(:user) { UcbRails::User.create!({uid: 1}, without_protection: true) }
  
  describe "login" do
    it "always false" do
      user
      manager.login("1").should be_false
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