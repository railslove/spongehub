class UserMailer < ActionMailer::Base
  default from: Rumble12.config.email.default_from

  def blame_or_fame(user, space)
    @user = user
    @url  = space_url(space)
    subject = user.rating.blame? ? "You've got blamed!" : "You've got famed!"
    mail(to: user.email, subject: subject)    
  end

  def invite(user, space)
    @url  = space_url(space)
    mail(to: user.email, subject: "You've got an invitation for a space on SpongeHub")        
  end
end
