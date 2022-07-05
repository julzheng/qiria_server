import Config

config :logger,
  backends: [:console],
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]

config :qiria, env: Mix.env()

config :qiria, ecto_repos: [Infrastructure.Persistence.Repo]

config :qiria, Client.QiriaGraphQL.Endpoint,
  server: true,
  secret_key_base: "TuEA2Ia0wcMZ8QXZlvGBOKCKpEQjk9V3vW5AYuAAfkpecTqZIdZYzAd7y3CmjiJK"

#       render_errors: [accepts: ~w(json)]

config :qiria,
       Client.Web.Endpoint,
       server: true,
       render_errors: [
         view: Client.Web.ErrorView,
         accepts: ~w(json),
         layout: false
       ],
       secret_key_base: "TuEA2Ia0wcMZ8QXZlvGBOKCKpEQjk9V3vW5AYuAAfkpecTqZIdZYzAd7y3CmjiJK",
       live_view: [signing_salt: "Frlx2pECXUe4SQOh"],
       pubsub_server: Web.PubSub

config :qiria, :pow,
  user: Infrastructure.Persistence.Schema.Auth,
  repo: Infrastructure.Persistence.Repo

config :phoenix, :json_library, Jason

# config :phoenix, :serve_endpoints, true

# config :mime, :types, %{
#       "application/xml" => ["xml"]
# }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
import_config "#{Mix.env()}.secret.exs"
