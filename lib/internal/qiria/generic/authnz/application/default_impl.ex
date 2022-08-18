defmodule Qiria.Authnz.Application.DefaultImpl do
  alias Plug.Conn
  alias Qiria.Authnz.Application.AuthnPass
  alias Qiria.Authnz.Application.Credential
  alias Qiria.Boundary.Repository.AccountStore

  @impl true
  @spec authenticate(Credential.t(), Conn.t()) :: {:ok, AuthnPass.t()} | {:error, :authn_failed}
  def authenticate(credentials, conn) do
    with true <- AccountStore.is_account_exist?(credentials),
         {:ok, auth} = AccountStore.get_account_by(credentials |> Map.from_struct(), "email"),
         credentials = %Credential{credentials | password_hash: auth.password_hash},
         true <- Argon2.verify_pass(credentials.password, credentials.password_hash) do
      conn
      |> Pow.Plug.authenticate_user(%{
        "email" => credentials.email,
        "password" => credentials.password
      })
      |> case do
        {:ok, conn} ->
          {:ok,
           %AuthnPass{
             access_token: conn.private.api_access_token,
             access_token_expiry_in: conn.private.access_token_expiry_in,
             renewal_token: conn.private.api_renewal_token,
             renewal_token_expiry_in: conn.private.renewal_token_expiry_in,
             user_id: auth.user_id
           }}

        {:error, _} ->
          {:error, :authn_failed}
      end
    else
      false -> {:error, :wrong_credentials}
    end
  end
end
