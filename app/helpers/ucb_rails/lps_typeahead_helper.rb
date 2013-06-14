module UcbRails::LpsTypeaheadHelper
  
  def lps_typeahead_search_field(options={})
    name = options.delete(:name) || 'person_search'
    label = options.delete(:label) || 'User'
    value = options.delete(:value) || params[name]
    placeholder = options.delete(:placeholder) || 'Type name to search'
    hint = options.delete(:hint) || 'Click icon to search CalNet'
    
    result_link_text = options.delete(:result_link_text) || 'Select'
    result_link_class = options.delete(:result_link_class) || 'lps-typeahead-item'
    
    uid_dom_id = options.delete(:uid_dom_id) || 'uid'
    search_url = options.delete(:search_url) || typeahead_search_ucb_rails_admin_users_path
    
    content_tag(:div, class: 'control-group lps-typeahead') do
      label_tag(name, label) +
      content_tag(:div, class: 'controls') do
        content_tag(:div, class: 'input-append') do
          text_field_tag(name, value, placeholder: placeholder, class: 'lps-typeahead-search', data: { uid_dom_id: uid_dom_id, url: search_url }) +
          content_tag(:span, class: 'add-on') do
            icon('search', class: 'ldap-person-search', data: {search_field_name: name, result_link_text: result_link_text, result_link_class: result_link_class})
          end
        end +
        content_tag(:p, hint, class: 'help-block')
      end
    end
  end
end