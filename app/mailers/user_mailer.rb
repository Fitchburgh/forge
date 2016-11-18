class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/entities/search'
    mail(to: 'ndsunc@gmail.com', subject: 'Welcome to Yazua Games!')
  end
end
