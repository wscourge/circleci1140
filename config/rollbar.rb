# frozen_string_literal: true

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  config.environment = Rails.env
  config.enabled = Rails.env.production?
  # config.person_method = 'my_current_user'
  # config.person_id_method = 'my_id'
  # config.person_username_method = 'username'
  # config.person_email_method = 'email'
  # config.custom_data_method = lambda { {:some_key => 'some_value' } }
  # config.exception_level_filters.merge!('CriticalException' => 'critical')
  # config.exception_level_filters.merge!('CriticalException' => lambda { |e| 'critical' })
  # config.use_async = true
  # config.async_handler = Proc.new { |payload| Thread.new { Rollbar.process_from_async_handler(payload) } }
  # config.use_sucker_punch
  config.use_sidekiq(queue: 'rollbar')
  config.sidekiq_threshold = 1
  # config.proxy = {
  #   host: 'http://some.proxy.server',
  #   port: 80,
  #   user: 'username_if_auth_required',
  #   password: 'password_if_auth_required'
  # }
end
