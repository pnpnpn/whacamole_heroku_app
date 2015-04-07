# HEROKU_APPS=appA:1000,appB:500

ENV['HEROKU_APPS'].split(',').each do |app_config|
  cfg = app_config.strip.split(':')
  app_name = cfg[0]
  restart_threshold = cfg[1].to_i
  puts "app_name=#{app_name} restart_threshold=#{restart_threshold}"
  Whacamole.configure(app_name) do |config|
    config.api_token = ENV['HEROKU_API_TOKEN']  # you could also paste your token in here as a string
    config.restart_threshold = restart_threshold  # in megabytes. default is 1000 (good for 2X dynos)

    # you can specify which dynos to watch for each app (default: `web`):
    config.dynos = %w{web worker}
  end
end
