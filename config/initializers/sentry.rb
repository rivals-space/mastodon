if ENV['SENTRY_DSN'].present?
  Sentry.init do |config|
    config.dsn = ENV['SENTRY_DSN']

    if ENV['SENTRY_ENVIRONMENT'].present?
      config.environment = ENV['SENTRY_ENVIRONMENT']
    end

    config.breadcrumbs_logger = [:active_support_logger, :http_logger]
    config.traces_sample_rate = 0.1
  end
end
