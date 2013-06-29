require 'spec_helper'

describe UcbRails::Configuration::Ldap do
  let(:klass) { UcbRails::Configuration::Ldap }
  let(:ldap) { UCB::LDAP }

  context 'no configuration passed' do
    let(:config) { nil }
    
    it "does not attempt to authenticate" do
      ldap.should_not_receive(:authenticate)
      klass.configure(config)
    end

    context 'not production' do
      it "sets test host" do
        klass.configure(config)
        ldap.host.should == 'nds-test.berkeley.edu'
        UCB::LDAP::Person.include_test_entries?.should be_true
      end
    end

    context 'production' do
      before { RailsEnvironment.stub rails_env: 'production' }
      
      it "sets production host" do
        klass.configure(config)
        ldap.host.should == 'nds.berkeley.edu'
        UCB::LDAP::Person.include_test_entries?.should be_false
      end
    end

  end

  context 'configuration passed' do
    let(:config) { {'host' => 'HOST', 'username' => 'USERNAME', 'password' => 'PASSWORD', 'include_test_entries' => true } }
    before { ldap.stub :authenticate }
    
    it "authenticates" do
      ldap.should_receive(:authenticate).with('USERNAME', 'PASSWORD')
      klass.configure(config)
    end

    context 'not production' do
      it "sets test host" do
        klass.configure(config)
        ldap.host.should == 'HOST'
        UCB::LDAP::Person.include_test_entries?.should be_true
      end
    end

    context 'production' do
      before { RailsEnvironment.stub rails_env: 'production' }
      
      it "sets production host" do
        klass.configure(config)
        ldap.host.should == 'HOST'
        UCB::LDAP::Person.include_test_entries?.should be_true
      end
    end

  end
  
end