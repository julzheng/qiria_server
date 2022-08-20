import Config

config :qiria,
       Client.QiriaGraphQL.Endpoint,
       url: [
         host: "http://127.0.0.1"
       ],
       http: [
         port: 4000
       ],
       debug_errors: true

config :qiria,
       Client.Web.Endpoint,
       url: [
         host: "http://127.0.0.1"
       ],
       http: [
         port: 4001
       ],
       debug_errors: true,
       code_reloader: true,
       check_origin: false
