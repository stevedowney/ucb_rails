module UcbRails
  module Renderer
    
    class LdapPersonSearchResultLink < Base
      attr_accessor :entry
      
      def initialize(template, entry, options={})
        super template, options
        self.entry = entry
      end
      
      def html
        button(text, :mini, :primary, link_options)
      end
      
      private
      
      def text
        @text ||= params["result-link-text"].presence || "Add"
      end
      
      def link_options
        {
          class: classes,
          url: item_url,
          data: {
            remote: remote,
            method: http_method,
            uid: entry.uid,
            first_name: entry.first_name,
            last_name: entry.last_name,
          }
        }
      end
      
      def classes
        extra_class = params['result-link-class'].presence || 'result-link-default'
        "result-link #{extra_class}"
      end
      
      def item_url
        url_param.present? ? url_and_person_params : '#'
      end
      
      def remote
        url_param.present?
      end

      def http_method
        params['result-link-http-method'] || :get
      end
      
      def url_param
        params["result-link-url"]
      end
      
      def url_and_person_params
        connector = url_param.include?("?") ? '&' : '?'
        "#{url_param}#{connector}#{person_params.to_query}"
      end
      
      def person_params
        {
          uid: entry.uid,
          first_name: entry.first_name,
          last_name: entry.last_name,
        }
      end
    end
    
  end
end