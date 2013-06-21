require 'spec_helper'

describe UcbRails::Configuration::Configuration do
  let(:test_config_file) { UcbRails::Engine.root.join('spec/fixtures/config.yml')}
  let(:config) { UcbRails::Configuration::Configuration.new(test_config_file) }
  
  describe '.initialize' do
    it "defaults to 'config/config.yml" do
      expect { UcbRails::Configuration::Configuration.new }
        .to raise_error(UcbRails::Configuration::Configuration::FileNotFound, %r{config/config.yml})
    end
    
    it "loads config file" do
      config.config_yaml.should == YAML.load_file(test_config_file)
    end
  end
  
  describe '.for' do
    it "finds top" do
      RailsEnvironment.stub rails_env: 'development'
      config.for('foo').should == { 'username' => 'top_username', "password"=>"top_password"}
    end

    it "prefers environment" do
      config.for('foo').should == { 'username' => 'test_username', "password"=>"test_password"}
    end
    
    it "not found okay if allow_nil" do
      config.for('not_found').should == nil
    end
  end

  describe '.for!' do
    it "finds" do
      config.for!('foo').should == { 'username' => 'test_username', "password"=>"test_password"}
    end

    it "raises if key not found" do
      expect { config.for!('not_found') }
        .to raise_error(UcbRails::Configuration::Configuration::KeyNotFound, %r{not_found})
    end
    
  end
end