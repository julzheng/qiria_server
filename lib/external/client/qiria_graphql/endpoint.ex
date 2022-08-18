defmodule Client.QiriaGraphQL.Endpoint do
  use Phoenix.Endpoint, otp_app: :qiria

  @session_options [
    store: :cookie,
    key: "_rest_api_key",
    signing_salt: "md3xQXbB"
  ]

  plug(Corsica,
    origins: "*",
    allow_headers: :all,
    log: [rejected: :warn, invalid: :debug, accepted: :debug]
  )

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["application/json", "text/*", "html"],
    json_decoder: Phoenix.json_library()
  )

  plug(Plug.Session, @session_options)
  plug(Pow.Plug.Session, otp_app: :qiria)
  plug(Client.QiriaGraphQL.Router)
end
