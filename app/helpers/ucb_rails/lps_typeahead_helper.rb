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
    UcbRails::Renderer::LpsTypeaheadSearchField.new(self, options).html
  end
  
end