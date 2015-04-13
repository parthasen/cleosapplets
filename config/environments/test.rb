Rails.application.configure do

  config.cache_store = :null_store
  config.identity_cache_store = :null_store
	#config.action_mailer.perform_deliveries = false
	config.action_mailer.raise_delivery_errors = true
	config.action_mailer.default_options = {from: 'testing123@example.com'}	
	# Emails get sent here ::ActionMailer::Base.deliveries array.
	config.action_mailer.delivery_method = :test
	config.action_mailer.smtp_settings = {
	  address:              'smtp.gmail.com',
	  port:                 587,
	  domain:               'localhost:3000',
	  user_name:            'testing123',
	  password:             'testing123',
	  authentication:       'plain',
	  enable_starttls_auto: true  }
	::Paperclip.options[:command_path] = "/usr/bin/"
	#Set Paperclip defaults here
	#Paperclip::Attachment.default_options[:storage] = :fog

  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  #config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end