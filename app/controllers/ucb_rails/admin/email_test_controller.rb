class UcbRails::Admin::EmailTestController < UcbRails::Admin::BaseController
  
  def index
  end
  
  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}\z/

  def send_email
    email = params[:email]
    
    if email =~ EMAIL_REGEXP
      @email_result = UcbRails::TestMailer.test(email).deliver
      flash.now[:success] = 'Email sent.'
    else
      flash.now[:error] = 'Invalid email address'
    end
    
    render 'index'
  end
end