if ENV['SENTRY_DSN'].present?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']

    if ENV['SENTRY_ENVIRONMENT'].present?
      config.environment = ENV['SENTRY_ENVIRONMENT']
    end

    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.traces_sample_rate = 0.1

    config.before_send = lambda do |event, hint|
      ignored_errors = [
        HTTP::TimeoutError,
        HTTP::ConnectionError,
        OpenSSL::SSL::SSLError,
        Stoplight::Error::RedLight
      ]

      if hint[:exception]&.is_a?(Exception) && ignored_errors.any? { |error_class| hint[:exception].is_a?(error_class) }
        nil
      else
        event
      end
    end
  end
end
