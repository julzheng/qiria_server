defmodule Qiria.Authnz.Application.Credential do
  defstruct ~w[email password password_hash]a

  @type t() :: %__MODULE__{
          email: String.t(),
          password: String.t(),
          password_hash: String.t()
        }
end

defmodule Qiria.Authnz.Application.AuthnPass do
  defstruct ~w[access_token access_token_expiry_in renewal_token renewal_token_expiry_in user_id]a

  @type t() :: %__MODULE__{
          access_token: String.t(),
          access_token_expiry_in: integer(),
          renewal_token: String.t(),
          renewal_token_expiry_in: integer(),
          user_id: integer()
        }
end
