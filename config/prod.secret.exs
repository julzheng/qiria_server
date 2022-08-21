import Config

config :qiria,
       Infrastructure.Persistence.Repo,
       database: "qiria",
       username: "root",
       password: "root",
       hostname: "localhost",
       socket: "/run/mysqld/mysqld.sock",
       # OR use a URL to connect instead
       url: "mariadb://root:root@localhost/qiria"

config :vaultex, :vault_token, "vault"

config :vaultex, :vault_addr, "http://172.17.0.2:8200"