require 'spec_helper'

describe UcbRails::Credentials do
  let(:test_credentials_file) { UcbRails::Engine.root.join('spec/fixtures/credentials.yml')}
  let(:credentials) { UcbRails::Credentials.new(test_credentials_file) }
  
  describe '.initialize' do
    it "defaults to 'config/credentials.yml" do
      expect { UcbRails::Credentials.new }
        .to raise_error(UcbRails::Credentials::FileNotFound, %r{config/credentials.yml})
    end
    
    it "loads config file" do
      credentials.credentials_yaml.should == YAML.load_file(test_credentials_file)
    end
    
    it "finds top" do
      RailsEnvironment.stub rails_env: 'development'
      credentials.for('foo').should == { 'username' => 'top_username', "password"=>"top_password"}
    end

    it "prefers environment" do
      credentials.for('foo').should == { 'username' => 'test_username', "password"=>"test_password"}
    end
    
    it "raises if key not found" do
      expect { credentials.for('not_found') }
        .to raise_error(UcbRails::Credentials::KeyNotFound, %r{not_found})
    end
    
    it "not found okay if allow_nil" do
      credentials.for('not_found', allow_nil: true).should == nil
    end
  end
  
end