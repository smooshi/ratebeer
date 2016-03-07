Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['bebe0f8d88599b567a0f'], ENV['9aeca7713353ea9a772cfc04970e668509f62fd8']
end