import Config

config :condapi,
  ecto_repos: [Condapi.Repo]

config :condapi, CondapiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CondapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Condapi.PubSub,
  live_view: [signing_salt: "y1ShapVi"]

config :condapi, Condapi.Mailer, adapter: Swoosh.Adapters.Local

config :swoosh, :api_client, false

config :condapi, Condapi.Auth.Guardian,
  issuer: "condapi",
  ttl: {3, :hours},
  secret_key:
    System.get_env(
      "GUARDIAN_SECRET_KEY",
      "P9HgWbpeuHpcoxrcWeXG+kXl31Bz9zXXiEuYqjwORazFHnRu5dDsW2IncHsM4uIr"
    )

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
