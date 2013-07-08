require 'spec_helper'

describe UcbRails::LpsTypeaheadHelper do
  
  it "default" do
    html = helper.lps_typeahead_search_field
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('div.input-append').tap do |div_ia|
          div_ia.find('input.typeahead-lps-search').tap do |input|
            input['autocomplete'].should == 'off'
            input['data-uid-dom-id'].should == 'uid'
            input['data-url'].should == '/ucb_rails/admin/users/typeahead_search'
            input['id'].should == 'person_search'
            input['name'].should == 'person_search'
            input['placeholder'].should == 'Type name to search'
            input['type'].should == 'text'
          end
        end
        div_c.find('span.add-on.ldap-person-search').tap do |span|
          span['data-url'].should == '/ucb_rails/admin/users/ldap_search'
          span['data-result-link-class'].should == 'lps-typeahead-item'
          span['data-result-link-text'].should == 'Select'
          span['data-search-field-name'].should == 'person_search'
          span.find('i.icon-search')
        end
        div_c.find('p.help-block', text: 'Click icon to search CalNet')
      end
    end
  end
  
  it "name" do
    html = helper.lps_typeahead_search_field(name: 'foo_name')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="foo_name"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('div.input-append').tap do |div_ia|
          div_ia.find('input.typeahead-lps-search').tap do |input|
            input['id'].should == 'foo_name'
            input['name'].should == 'foo_name'
          end
        end
        div_c.find('span.add-on.ldap-person-search').tap do |span|
          span['data-search-field-name'].should == 'foo_name'
        end
      end
    end
  end

  it "label" do
    html = helper.lps_typeahead_search_field(label: 'foo_label')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'foo_label')
    end
  end

  it "required" do
    html = helper.lps_typeahead_search_field(required: true)
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User').tap do |label|
        label.find('abbr[title="required"]', text: '*')
      end
    end
  end

  it "value" do
    html = helper.lps_typeahead_search_field(value: 'foo_value')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[value="foo_value"]')
    end
  end

  it "placeholder" do
    html = helper.lps_typeahead_search_field(placeholder: 'foo_placeholder')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[placeholder="foo_placeholder"]')
    end
  end

  it "hint" do
    html = helper.lps_typeahead_search_field(hint: 'foo_hint')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('p.help-block', text: 'foo_hint')
    end
  end

  it "result link text" do
    html = helper.lps_typeahead_search_field(result_link_text: 'foo_rlt')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span.add-on[data-result-link-text="foo_rlt"]')
    end
  end

  it "result link class" do
    html = helper.lps_typeahead_search_field(result_link_class: 'foo_rlc')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span.add-on[data-result-link-class="foo_rlc"]')
    end
  end

  it "uid dom id" do
    html = helper.lps_typeahead_search_field(uid_dom_id: 'uid2')
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[data-uid-dom-id="uid2"]')
    end
  end

  it "typeahead url" do
    html = helper.lps_typeahead_search_field(typeahead_url: '/ta_url')
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[data-url="/ta_url"]')
    end
  end

  it "ldap search url" do
    html = helper.lps_typeahead_search_field(ldap_search_url: '/ls_url')
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span[data-url="/ls_url"]')
    end
  end
  
  it "no ldap search" do
    html = helper.lps_typeahead_search_field(ldap_search: false)
    
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('input.typeahead-lps-search').tap do |input|
          input['autocomplete'].should == 'off'
          input['data-uid-dom-id'].should == 'uid'
          input['data-url'].should == '/ucb_rails/admin/users/typeahead_search'
          input['id'].should == 'person_search'
          input['name'].should == 'person_search'
          input['placeholder'].should == 'Type name to search'
          input['type'].should == 'text'
        end
        div_c.should_not have_css('p.help-block')
      end
    end
    
  end
  
  it "unknown option" do
    expect { helper.lps_typeahead_search_field(bad: 'option') }
      .to raise_error(ArgumentError, /Unknown lps_typeahead_search_field option/)
  end

end