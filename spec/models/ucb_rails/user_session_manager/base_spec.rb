require 'spec_helper'

describe UcbRails::UserSessionManager::Base do
  let(:klass) { UcbRails::UserSessionManager::Base }
  let(:manager) { klass.new }
  
  it "#login" do
    expect { manager.login("anything") }.to raise_error(NotImplementedError)
  end

  it '#current_user' do
    expect { manager.current_user("anything") }.to raise_error(NotImplementedError)
  end
  
  it '#log_request' do
    manager.log_request('anything').should be_nil
  end

  it '#logout' do
    manager.logout('anything').should be_nil
  end
  
  describe '.current_user, .current_user=' do
    before(:each) do
      
    end
    
    it "set / get" do
      klass.current_user = 'foo'
      klass.current_user.should == 'foo'
    end
  end
end