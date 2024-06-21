class WelcomeMailer < ApplicationMailer
  default from: 'noreply@lesmondesdemisscramee.fr'

  def welcome_email(user)
    @user = user
    @url  = 'http://mondesmisscramee.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
