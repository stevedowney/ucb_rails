require 'spec_helper'

describe 'UcbRails::Renderer::Base' do
  let(:template) {double('template')}
  let(:renderer_base) {UcbRails::Renderer::Base.new(template)}
    
  describe '.initialize' do
    it "sets template" do
      renderer_base.template.should == template
    end
    
    it "options defaults to {}" do
      renderer_base.options.should == {}
    end

    it "sets options" do
      options = double('options')
      renderer_base = UcbRails::Renderer::Base.new(template, options)
      renderer_base.options.should == options
    end
  end
  
  describe '#method_missing' do
    it "delegates methods to template" do
      template.should_receive(:foo).with(:bar)
      renderer_base.foo(:bar)
    end
  end
end