module UcbRails
  module Renderer
    
    class LpsTypeaheadSearchField < Base
      
      attr_accessor :name, :label, :required, :value, :placeholder, :hint, :result_link_text, :result_link_class, :uid_dom_id, :typeahead_url, :ldap_search_url, :ldap_search
      
      def initialize(template, options={})
        super
        parse_options
      end
      
      def html
        content_tag(:div, class: 'control-group lps-typeahead') do
          label_html +
          content_tag(:div, class: 'controls') do
            inputs +
            hint_html
          end
        end
      end
      
      private
      
      def label_html
        required_marker = required ? content_tag(:abbr, '*', title: 'required') + ' ' : ''
        label_classes = 'control-label'
        label_classes << ' required' if required
        
        label_tag(name, class: label_classes) do
          required_marker +
          label
        end
      end
      
      def inputs
        if ldap_search
          input_append_div
        else
          text_field_html
        end
      end

      def hint_html
        if ldap_search
          content_tag(:p, hint, class: 'help-block')
        end
      end
      
      def input_append_div
        content_tag(:div, class: 'input-append') do
          text_field_html + span_html
        end
      end

      def text_field_html
        text_field_tag(name, value, {
          autocomplete: 'off',
          class: 'typeahead-lps-search',
          placeholder: placeholder,
          data: {
            url: typeahead_url,
            uid_dom_id: uid_dom_id,
          }
        })
      end
      
      def span_html
        span_options = {
          class: 'add-on ldap-person-search',
          data: {
            url: ldap_search_url,
            search_field_name: name,
            result_link_text: result_link_text,
            result_link_class: result_link_class
          }
        }
        content_tag(:span, span_options) do
          icon('search')
        end
      end
      
      def parse_options
        self.name = options.delete(:name) || 'person_search'
        self.label = options.delete(:label) || 'User'
        self.required = options.delete(:required)
        self.value = options.delete(:value) || params[name]
        self.placeholder = options.delete(:placeholder) || 'Type name to search'
        self.hint = options.delete(:hint) || 'Click icon to search CalNet'
        self.result_link_text = options.delete(:result_link_text) || 'Select'
        self.result_link_class = options.delete(:result_link_class) || 'lps-typeahead-item'
        self.uid_dom_id = options.delete(:uid_dom_id) || 'uid'
        self.typeahead_url = options.delete(:typeahead_url) || typeahead_search_ucb_rails_admin_users_path
        self.ldap_search_url = options.delete(:ldap_search_url) || ldap_search_ucb_rails_admin_users_path
        self.ldap_search = options.delete(:ldap_search) != false
        
        validate_options
      end
      
      def validate_options
        return if options.blank?
        
        msg = "Unknown lps_typeahead_search_field option(s): #{options.keys.map(&:inspect).join(', ')}. "
        msg << "Did you mean one of :name, :required, :label, :value, :placeholder, :hint, :ldap_search, :ldap_search_url, :result_link_text, :result_link_class, :uid_dom_id, :typeahead_url"
        raise ArgumentError, msg
      end
      
    end
  end
end