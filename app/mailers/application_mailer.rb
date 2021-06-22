class ApplicationMailer < ActionMailer::Base
  default from: 'denunciaciudadana.team02@gmail.com'

  layout 'mailer'

  def denounce_created
    @denounce = params[:denounce]
    @user     = params[:user]
    mail(
      to: @user.email,
      subject: 'A new denounce has been created in one of your places of interest',
      template_path: 'notifications'
    )
  end
end
