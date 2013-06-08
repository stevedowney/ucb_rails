class ActiveRecord::Base
  
  # Create dom id for new or persisted instances.  Optionsal _prefix_ parameter.
  #
  #   User.new.dom_id                => "new_user"
  #   User.new.dom_id('my_prefix')   => "my_prefix_user"
  #   User.find(10).dom_id           => "user_10"
  #   User.find(10).dom_id('edit')   => "edit_user_10"
  #
  def dom_id(prefix = nil) 
    prefix ||= 'new' unless id
    [ prefix, self.class.model_name.singular, id ].compact * '_'
  end

  # Assists in using haml object shortcut [] to put attributes on elements
  #
  #   %tr[share]
  #   #=> <tr id="share_1" class="shares">
  #
  #   %tr[share, :class => 'foo', 'data-bar' => 42]  
  #   #=> <tr id="share_1" class="shares foo" data-bar="42">
  #
  def haml_attributes(options = {})
    options_out = (options || {}).merge(
      'id' => dom_id,
      'always_css_class' => self.class.model_name.singular)
      
    self.class.haml_attributes_helper(options_out)
  end

  class << self

    def dom_id
      model_name.plural
    end
    
    # Assists in using haml object shortcut [] to put attributes on elements
    #
    #   %table[Share]
    #   #=> <table id="shares" class="table">
    #
    #   %table[Share, :class => 'foo', 'data-bar' => 42]  
    #   #=> <table id="shares" class="table foo" data-bar="42">
    #
    def haml_attributes(options = {})
      options_out = (options || {}).merge('always_css_class' => 'table')
      haml_attributes_helper(options_out)
    end
    
    def haml_attributes_helper(options = {})
      attributes = options.stringify_keys

      attributes["id"] = attributes.delete("id") || dom_id
      attributes["class"] = [attributes.delete('always_css_class'), attributes.delete("class")].
          flatten.map(&:presence).compact
      attributes
    end

  end
  
end
