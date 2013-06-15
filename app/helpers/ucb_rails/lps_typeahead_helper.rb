# Helper class that produces a person search widget than includes typeahead and
# CalNet lookup functionality.
module UcbRails::LpsTypeaheadHelper

  # @option options [Symbol] :name (:person_search) the name of the <input> field
  # @option options [String] :label ('User') the text of the field label
  # @option options [Boolean] :required (false) is the field required
  # @option options [String] :value (params[:name]) the value of the field
  # @option options [String] :placeholder ('Type name to search') the html +placeholder+ attribute
  # @option options [String] :hint ('Click icon to search CalNet') hint text
  # @option options [String] :result_link_text ('Select') the text of the link button in search results
  # @option options [String] :result_link_class ('lps-typeahead-item') class to be added the the results link
  # @option options [String] :uid_dom_id ('uid') the dom-id of the (hidden) uid <input>
  # @option options [String] :search_url ('/ucb_rails/admin/users/typeahead_search') the search url for typeahead
  def lps_typeahead_search_field(options={})
    name = options.delete(:name) || 'person_search'
    label = options.delete(:label) || 'User'
    required = options.delete(:required)
    value = options.delete(:value) || params[name]
    placeholder = options.delete(:placeholder) || 'Type name to search'
    hint = options.delete(:hint) || 'Click icon to search CalNet'
    
    result_link_text = options.delete(:result_link_text) || 'Select'
    result_link_class = options.delete(:result_link_class) || 'lps-typeahead-item'
    
    uid_dom_id = options.delete(:uid_dom_id) || 'uid'
    search_url = options.delete(:search_url) || typeahead_search_ucb_rails_admin_users_path
    
    if options.present?
      msg = "Unknown lps_typeahead_search_field option(s): #{options.keys.map(&:inspect).join(', ')}. "
      msg << "Did you mean one of :name, :required, :label, :value, :placeholder, :hint, :result_link_text, :result_link_class, :uid_dom_id, :search_url"
      raise ArgumentError, msg
    end
    
    content_tag(:div, class: 'control-group lps-typeahead') do
      label_tag(name, class: label_classes(required)) do
        required_marker(required) +
        label
         
      end +
      content_tag(:div, class: 'controls') do
        content_tag(:div, class: 'input-append') do
          text_field_tag(name, value, placeholder: placeholder, class: 'typeahead-lps-search', data: { uid_dom_id: uid_dom_id, url: search_url }) +
          content_tag(:span, class: 'add-on') do
            icon('search', class: 'ldap-person-search', data: {search_field_name: name, result_link_text: result_link_text, result_link_class: result_link_class})
          end
        end +
        content_tag(:p, hint, class: 'help-block')
      end
    end
  end
  
  private
  
  def label_classes(required)
    Array['control-label'].tap do |klasses|
      klasses << 'required' if required
    end
  end
  
  def required_marker(required)
    if required
      content_tag(:abbr, '*', title: 'required') + ' '
    else
      ''
    end
  end
end