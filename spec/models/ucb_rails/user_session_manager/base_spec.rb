require 'spec_helper'

describe UcbRails::UserSessionManager::Base do
  let(:manager) { UcbRails::UserSessionManager::Base.new }
  
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
end