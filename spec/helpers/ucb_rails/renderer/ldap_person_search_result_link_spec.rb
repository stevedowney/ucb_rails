require 'spec_helper'

describe 'UcbRails::Renderer::LdapPersonSearchResultLink' do
  ActionView::Base.send(:include, UcbRails::LdapPersonSearchHelper)
  ActionView::Base.send(:include, UcbRails::ExtractableHelper)
  ActionView::Base.send(:include, Bootstrap::ButtonHelper)
  ActionView::Base.send(:include, Bootstrap::CommonHelper)
  
  let(:klass) { UcbRails::Renderer::LdapPersonSearchResultLink }
  let(:entry) { mock('entry', uid: '123', first_name: 'Art', last_name: 'Andrews', email: 'aa@example.com') }
  let(:template) do
    ActionView::Base.new.tap do |t|
      t.stub(params: {})
    end
  end
  
  it "defaults" do
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link.result-link-default')
    
    link.text.should == 'Add'
    link['href'].should == '#'
    link['data-method'].should == 'get'
    link['data-uid'].should == '123'
    link['data-first-name'].should == 'Art'
    link['data-last-name'].should == 'Andrews'
    link['data-email'].should == 'aa@example.com'
  end
  
  it "url" do
    template.stub(params: {"result-link-url" => '/url'})
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')
    
    link['href'].should == "/url?first_name=Art&last_name=Andrews&uid=123"
    link['data-remote'].should == 'true'
  end

  it "url w/param, method" do
    template.stub(params: {"result-link-url" => '/url?foo=bar', 'result-link-http-method' => :post})
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')
    
    link['href'].should == "/url?foo=bar&first_name=Art&last_name=Andrews&uid=123"
    link['class'].should_not match /result-link-default/
    link['data-remote'].should == 'true'
    link['data-method'].should == 'post'
  end
  
  it "change label" do
    template.stub(params: {"result-link-text" => 'Select'})
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')
    
    link.text.should == 'Select'
  end
  
  it "additional class" do
    template.stub(params: {"result-link-class" => 'my-class'})
    html = klass.new(template, entry, class: 'my-class').html
    link = Capybara.string(html).find('a.result-link.my-class')
    link['class'].should_not match /result-link-default/
  end
  
  it "exists" do
    template.instance_variable_set("@lps_existing_uids", ["123"])
    html = klass.new(template, entry, class: 'my-class').html
    html.should == 'Exists'
  end
end