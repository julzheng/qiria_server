defmodule Infrastructure.Persistence.Repo do
  use Ecto.Repo,
      otp_app: :qiria,
      adapter: Ecto.Adapters.MyXQL
end
