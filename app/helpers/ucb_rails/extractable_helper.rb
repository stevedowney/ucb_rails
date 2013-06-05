# These methods should be extracted into own gem.
module UcbRails::ExtractableHelper
  
  def js_void
    @_js_void ||= "javascript:void(0)"
  end
  
  def boolean_display(boolean)
    ( boolean ? '&#10004;' : '&nbsp;' ).html_safe
  end


  def datetime_to_s(datetime, format)
    if datetime.present?
      datetime.localtime.to_s(format)
    else
      ''
    end
  end

  def bs_table(*args)
    options = canonicalize_options(args.extract_options!)
    
    ar_class = args.first
    if ar_class.respond_to?(:haml_attributes)
      options[:id] ||= ar_class.haml_attributes["id"]
      options = ensure_class(options, ar_class.haml_attributes["class"])
    end

    options = ensure_class(options, %w(table table-bordered table-striped table-hover))

    content_tag(:table, options) do
      yield
    end
  end
end