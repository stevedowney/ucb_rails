class UcbRails::Admin::ForceExceptionController < UcbRails::Admin::BaseController
  
  def index
    raise 'Exception raised to text ExceptionNotifier'
  end
  
end