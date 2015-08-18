security = AppConfiguration.for :security
token = security.secret_token.blank? ? ENV["SECURITY_SECRET_KEY_BASE"] : security.secret_token

if token.blank? || !Rails.env.production?
  #exempt tests or db:migrate commands
  token = rand(100000000).to_s * 11
end

if token.blank? 
  raise "secret_token has not been set. Create a .security.yml file with the secret_token or set the SECURITY_SECRET_KEY_BASE env variable"
end
CodeAmbush::Application.config.secret_token = token
