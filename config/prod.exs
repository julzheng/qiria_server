import Config

config :qiria, :hello, url: "http://www.google.com"

config :qiria,
       Client.QiriaGraphQL.Endpoint,
       url: [
         host: "http://0.0.0.0"
       ],
       http: [
         port: 4000
       ]

config :qiria,
       Client.Web.Endpoint,
       url: [
         host: "http://0.0.0.0"
       ],
       http: [
         port: 4001
       ]
