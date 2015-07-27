OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '678816145563684', '35d51e133ce481b294fd68a948c73cd3'
end
