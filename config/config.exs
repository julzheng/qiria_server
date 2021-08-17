import Config

config :qiria, ecto_repos: [Infrastructure.Persistence.MariaDB.Repo]

config :qiria, Client.QiriaGraphQL.Endpoint, server: true
#       render_errors: [accepts: ~w(json)]

config :qiria,
       Client.RestAPI.Endpoint,
       server: true,
       render_errors: [
         view: Client.RestAPI.ErrorView,
         accepts: ~w(json),
         layout: false
       ],
       secret_key_base: "TuEA2Ia0wcMZ8QXZlvGBOKCKpEQjk9V3vW5AYuAAfkpecTqZIdZYzAd7y3CmjiJK"

config :qiria, :pow,
       user: Infrastructure.Persistence.MariaDB.Schema.Auth,
       repo: Infrastructure.Persistence.MariaDB.Repo

config :phoenix, :json_library, Jason

# config :phoenix, :serve_endpoints, true

# config :mime, :types, %{
#       "application/xml" => ["xml"]
# }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
import_config "#{Mix.env()}.secret.exs"
