# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :rest_api, Client.RestAPI.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NuDMjlTA+xezp6pbxVQpt6447iRKlBZ0l68g1CHWEfvVIu8PvCSqOpEaubsvZkXB",
  render_errors: [view: Client.RestAPI.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: RestApi.PubSub,
  live_view: [signing_salt: "gtZypZXX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"