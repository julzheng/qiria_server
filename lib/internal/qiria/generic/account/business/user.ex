defmodule Qiria.Account.Business.User do
  @moduledoc false

  defstruct ~w[fullname email password password_hash]a

  @type t() :: %__MODULE__{
          fullname: String.t(),
          email: String.t(),
          password: String.t(),
          password_hash: String.t()
        }

  def register(fields), do: struct!(__MODULE__, fields)

  @spec is_email_exist?(User.t()) :: boolean()
  def is_email_exist?(user) do
    case user.email do
      nil -> false
      _ -> true
    end
  end



end
