Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, Rumble12.config.authentication.twitter[:key], Rumble12.config.authentication.twitter[:secret]
  provider :github, Rumble12.config.authentication.github[:key], Rumble12.config.authentication.github[:secret]
  provider :facebook, Rumble12.config.authentication.facebook[:key], Rumble12.config.authentication.facebook[:secret]
  provider :google_oauth2, Rumble12.config.authentication.google[:key], Rumble12.config.authentication.google[:secret]
  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end