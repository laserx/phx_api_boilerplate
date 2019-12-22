use Mix.Config

# Configure your database
config :phx_api_boilerplate, PhxApiBoilerplate.Repo,
  username: "postgres",
  password: "postgres",
  database: "phx_api_boilerplate_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phx_api_boilerplate, PhxApiBoilerplateWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
