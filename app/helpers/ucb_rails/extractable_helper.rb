# These methods should be extracted into own gem.
module UcbRails::ExtractableHelper
  
  def ucbr_table_tag(*args)
    options = canonicalize_options(args.extract_options!)
    
    ar_class = args.first
    if ar_class.respond_to?(:haml_attributes)
      options[:id] ||= ar_class.haml_attributes["id"]
      options = ensure_class(options, ar_class.haml_attributes["class"])
    end

    bs_table_tag(options) do
      yield
    end
  end
end