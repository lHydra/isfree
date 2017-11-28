class UserNotifier < ActionMailer::Base
  default from: 'g3orge.miller@gmail.com'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_participation_email(user, crease)
    @crease = crease
    @user = user
    mail( to: @user.email,
    subject: 'Вы записались на участие в складчине' )
  end
end
