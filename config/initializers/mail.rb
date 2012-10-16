ActionMailer::Base.smtp_settings = {
  :address              => Rumble12.config.email.address,
  :port                 => Rumble12.config.email.port,
  :domain               => Rumble12.config.email.domain,
  :user_name            => Rumble12.config.email.user_name,
  :password             => Rumble12.config.email.password,
  :authentication       => Rumble12.config.email.authentication,
  :enable_starttls_auto => Rumble12.config.email.enable_starttls_auto
}

# Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?