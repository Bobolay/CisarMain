class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::OutputSafetyHelper
  include ActionView::Helpers::TagHelper
  include MailerHelper
  include ActionView::Context


  def reservation_request(r)
    @request_resource = r

    mail(
        template_name: "reservation_request",
        to: receivers("reservation_request"),
        from: "Cisar <#{ActionMailer::Base.smtp_settings[:user_name]}>",
        subject: "New reservation request"
    )
  end


end