class UserMailer < ApplicationMailer

  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Awesome Answers: Password Reset"
  end
end
