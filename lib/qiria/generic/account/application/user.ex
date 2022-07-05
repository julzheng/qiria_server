defmodule Qiria.Account.Application.User do
  use Ecto.Schema

  @type t :: %__MODULE__{
               fullname: String.t(),
               email: String.t(),
               password: String.t(),
               password_hash: String.t()
             }
  @primary_key false
  embedded_schema do
    field(:id, :id)
    field(:fullname, :string)
    field(:email, :string)
    field(:password, :string, redact: true)
    field(:password_hash, :string)
  end
end
