import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :weather_app, WeatherApp.Repo,
  username: "root",
  password: System.get_env("MYSQL_PASS"),
  hostname: "localhost",
  database: "weather_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :weather_app, WeatherAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "u2m1ngi7meZyPSl0W4gZBI4Hh+oaFgVCH1e9hoy9w6lot6nSp7oK9RclFCHlrjc+",
  server: false

# In test we don't send emails.
config :weather_app, WeatherApp.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
config :weather_app, api_client: ApiClientBehaviourMock
