# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_contact, ecto_repos: [SimpleContact.Repo]

# Configures the endpoint
config :simple_contact, SimpleContactWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ogn1n6xKv2Jk3/DzmIfMKMGjV+Ee48dQaTeWnRDmygjO5VqmG9FY6LoxQldV7tk6",
  render_errors: [view: SimpleContactWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SimpleContact.PubSub,
  live_view: [signing_salt: "mq5h+Kpo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
