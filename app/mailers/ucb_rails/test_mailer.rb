module UcbRails
  class TestMailer < ActionMailer::Base
    layout false

    # Verify email configuration, from irb (e.g.):
    #
    #   TestMailer.test('email@example.com').deliver
    def test(email)
      subject = "#{UcbRails[:email_subject_prefix]} Test Email"

      mail(to: email, subject: subject)
    end

  end
end