require 'spec_helper'

describe UcbRails::Configuration::Email do
  # let(:test_config_file) { UcbRails::Engine.root.join('spec/fixtures/config.yml')}
  let(:klass) { UcbRails::Configuration::Email }
  let(:amb) { ActionMailer::Base }
  
  after(:all) do
    ActionMailer::Base.delivery_method = :test
  end
  
  describe '.new' do
    it "sets config" do
      klass.new({'foo' => 'bar'}).hash.should == {'foo' => 'bar'}
    end
    
    it "requires a hash" do
      expect { klass.new('foo') }
        .to raise_error(UcbRails::Configuration::Email::ArgumentError)
    end
  end
  
  describe 'delivery_method' do
    it "defaults to smtp" do
      klass.new({})
      amb.delivery_method.should == :smtp
    end
    
    it "can be set" do
      klass.new({'delivery_method' => 'sendmail'})
      amb.delivery_method.should == :sendmail
    end
  end
  
  describe 'default' do
    it "adds to default" do
      klass.new({'default' => {'foo' => 'bar'}})
      amb.default['foo'].should == 'bar'
    end
  end
  
  describe 'default_url_options' do
    it "sets default_url_options" do
      config = {'default_url_options' => { 'host' => 'localhost' } }
      klass.new(config)
      amb.default_url_options.should == config['default_url_options']
    end
  end
  
  describe 'raise_delivery_errors' do
    it "defaults to true" do
      klass.new({})
      amb.raise_delivery_errors.should be_true
    end
    
    it "can be set" do
      config = { 'raise_delivery_errors' => false}
      klass.new(config)
      amb.raise_delivery_errors.should be_false
    end
  end

  describe 'sendmail_settings' do
    it "sets send_settings, symbolizes keys" do
      config = {'sendmail_settings' => { 'location' => '/app/bin/sendmail'} }
      klass.new(config)
      amb.sendmail_settings.should == { location: '/app/bin/sendmail'}
    end
  end
  
  describe 'smtp_settings' do
    it "sets smtp_settings, symbolizes keys" do
      config = {'smtp_settings' => { 'port' => 587, 'domain' => 'gmail.com'}}
      klass.new(config)
      amb.smtp_settings.should == { port: 587, domain: 'gmail.com'}
    end
  end
  
  describe 'subject_prefix' do
    it "defaults to ''" do
      klass.new({})
      UcbRails[:email_subject_prefix].should == ''
    end
    
    it "can be set" do
      config = {'subject_prefix' => '[MyApp]'}
      klass.new(config)
      UcbRails[:email_subject_prefix].should == '[MyApp]'
    end
    
    it "substitues Rails env" do
      config = {'subject_prefix' => '[MyApp {env}]'}
      klass.new(config)
      UcbRails[:email_subject_prefix].should == '[MyApp TST]'
    end
  end
end