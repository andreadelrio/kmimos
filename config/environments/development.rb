ServihogarRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  # mailgun
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :authentication => :plain,
    :address => "smtp.mandrillapp.com",
    :port => 25,
    :user_name => ENV["MANDRILL_USERNAME"],
    :password => ENV["MANDRILL_API_KEY"]
  }  
  
  
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => 'servihogar',
      :access_key_id =>  'AKIAJPN6EZBZJY3UHKQA',
      :secret_access_key => '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'
    }
  }
  
  config.cache_classes = true
  config.eager_load = true

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false
end
