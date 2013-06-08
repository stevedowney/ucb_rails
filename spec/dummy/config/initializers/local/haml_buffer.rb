class Haml::Buffer
  
  alias_method :orig_parse_object_ref, :parse_object_ref
  
  # Override the method that figures out id/class given something like:
  # 
  #   %tag[object]
  #
  # An object/class can implement :haml_id_and_class_hash and use that
  # rather than the default.
  def parse_object_ref(ref)
    object, options = ref

    if object.respond_to?(:haml_attributes)
      object.haml_attributes(options)
    else
      orig_parse_object_ref(ref)
    end
  end
end