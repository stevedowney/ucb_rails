module UcbRails

  # Class for getting results for ldap person search typeahead fields.
  #
  # By default it will search the UcbRails::User table, but this is configurable:
  #
  # @example
  #   class MyController < ApplicationController
  # 
  #     def search
  #       uta = UserTypeahead.new
  #       render :json uta.results('art')
  #     end
  #
  #   end
  #
  class UserTypeahead
    attr_accessor :klass, :search_column, :uid_column, :first_last_name_column, :limit
    
    # Constructor
    #
    # @example
    #   UserTypeahead.new
    #   UserTypeahead.new(klass: Faculty, search_column: 'full_name', uid_column: 'net_id', limit: 25)
    # @param options [Hash]
    # @option options [Object] :klass (UcbRails::User) the (+ActiveRecord+) class to search
    # @option options [Symbol] :search_column (:first_last_name) the column to search
    # @option options [Symbol] :uid_column (:uid) the column holding the +uid+
    # @option options [Symbol] :first_last_name (search_column) the column holding the first/last names
    # @option options [FixNum] :limit (10) number of rows to return
    # @return [UcbRails::UserTypeahead]
    def initialize(options={})
      self.klass = options.delete(:klass) || UcbRails::User
      self.search_column = options.delete(:search_column) || :first_last_name
      self.limit = options.delete(:limit) || 10
      self.uid_column = options.delete(:uid_column) || :uid
      self.first_last_name_column = options.delete(:first_last_name_column) || search_column
      validate_options(options)
    end
    
    # Returns the data matching _query_.
    # @example
    #   uta = UserTypeahead.new
    #   uta.results('art')        #=> [{uid: '1', first_last_name: 'Art Andrews'}, ...]
    # @param query [String] search term to match name fields on
    # @return [Array(Hash)] 
    def results(query)
      klass
        .where(where(query))
        .limit(limit)
        .map { |row| row_to_hash(row) }
    end
    
    private
    
    def where(query)
      tokens = query.to_s.strip.split(/\s+/)
      wheres = tokens.map { |e| "#{search_column} like ?" }.join(' and ')
      values = tokens.map { |e| "%#{e}%" }
      
      ["#{wheres}", *values]
    end
    
    def row_to_hash(row)
      {
        uid: row.send(uid_column),
        first_last_name: row.send(first_last_name_column)
      }
    end
    
    def validate_options(options)
      if options.present?
        msg = "Unknown UcbRails::UserTypeahead.new option(s): #{options.keys.map(&:inspect).join(', ')}. "
        msg << "Did you mean one of :klass, :search_column, :uid_column, :first_last_name_column, :limit"
        raise ArgumentError, msg
      end
      
    end
  end
  
end