module UcbRails
  module Renderer
    
    class LpsTypeaheadSearchField < Base
      
      attr_accessor :name, :label, :required, :value, :placeholder, :hint, :result_link_text, :result_link_class, :uid_dom_id, :search_url
      
      def initialize(template, options={})
        super
        parse_options
      end
      
      def html
        content_tag(:div, class: 'control-group lps-typeahead') do
          label_html +
          content_tag(:div, class: 'controls') do
            content_tag(:div, class: 'input-append') do
              text_field_html +
              span_html
            end +
            content_tag(:p, hint, class: 'help-block')
          end
        end
      end
      
      private
      
      def label_html
        label_tag(name, class: label_classes(required)) do
          required_marker(required) +
          label
        end
      end
      
      def text_field_html
        text_field_tag(name, value, {
          autocomplete: 'off',
          class: 'typeahead-lps-search',
          placeholder: placeholder,
          data: {
            uid_dom_id: uid_dom_id,
            url: search_url
          }
        })
      end
      
      def span_html
        span_options = {
          class: 'add-on ldap-person-search',
          data: {
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
        self.search_url = options.delete(:search_url) || typeahead_search_ucb_rails_admin_users_path
        
        validate_options
      end
      
      def validate_options
        return if options.blank?
        
        msg = "Unknown lps_typeahead_search_field option(s): #{options.keys.map(&:inspect).join(', ')}. "
        msg << "Did you mean one of :name, :required, :label, :value, :placeholder, :hint, :result_link_text, :result_link_class, :uid_dom_id, :search_url"
        raise ArgumentError, msg
      end
      
    end
  end
end