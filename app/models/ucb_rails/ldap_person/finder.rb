module UcbRails::LdapPerson
  class Finder
    BlankSearchTermsError = Class.new(StandardError)
    PersonNotFound = Class.new(StandardError)

    def benchmark(message = "Benchmarking")
      result = nil
      ms = Benchmark.ms { result = yield }
      Rails.logger.debug "#{message} #{ms}"
      result
    end

    def find_by_uid(uid)
      benchmark("find_by_uid(#{uid})") do
        find_by_attributes(:uid => uid.to_s).first
      end
    end

    def find_by_uid!(uid)
      find_by_uid(uid) or raise(PersonNotFound, "uid=#{uid.inspect}")
    end

    def find_by_first_last(first_name, last_name, options={})
      raise BlankSearchTermsError unless first_name.present? || last_name.present?
      
      find_by_attributes(:givenname => first_name, :sn => last_name).tap do |entries|
        if options[:sort]
          sort_symbol = options[:sort]
          entries.sort_by!(&options[:sort])
        end
      end
    end

    def find_by_attributes(attributes)
      attributes.each { |k, v| attributes.delete(k) if v.blank?  }
      UCB::LDAP::Person.
        search(:filter => build_filter(attributes)).
        map { |ldap_entry| new_ldap_person_entry(ldap_entry) }
    end

    def new_ldap_person_entry(ldap_entry)
      Entry.new(
        :uid => ldap_entry.uid,
        :calnet_id => ldap_entry.berkeleyedukerberosprincipalstring.first,
        :first_name => ldap_entry.givenname.first,
        :last_name => ldap_entry.sn.first,
        :email => ldap_entry.mail.first,
        :phone => ldap_entry.phone,  
        :departments => ldap_entry.berkeleyeduunithrdeptname,
        :affiliations => ldap_entry.berkeleyeduaffiliations
      )
    end

    def build_filter(attrs)
      filter_parts = attrs.map { |k, v| build_filter_part(k, v) }
      filter = filter_parts.inject { |accum, filter| accum.send(:&, filter) }
      filter
    end

    def build_filter_part(key, value)
      value = key.to_s == 'uid' ? value : "#{value}*"
      Net::LDAP::Filter.eq(key.to_s, value)
    end

    class << self
      def klass
        if RailsEnvironment.test? || UcbRails[:omniauth_provider] == :developer
          UcbRails::LdapPerson::TestFinder
        else
          UcbRails::LdapPerson::Finder
        end
      end

      def method_missing(method, *args)
        klass.new.send(method, *args)
      end
    end
    
  end
end