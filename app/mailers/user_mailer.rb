class UserMailer < ApplicationMailer
  default from: "manager@kachi_events.com"

  def upcoming_events
    @user = params[:user]
    @events = params[:events]
    mail(to: @user.email, subject: "Your events this week")
  end
end
