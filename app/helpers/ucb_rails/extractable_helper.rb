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

end