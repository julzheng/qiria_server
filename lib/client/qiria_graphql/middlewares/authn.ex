defmodule Client.QiriaGraphQL.Middlewares.Authn do
  @behaviour Absinthe.Middleware

  import Library.Helpers.ErrorCodes

  def call(%{context: %{current_user_id: _, access_token: _}} = resolution, _info), do: resolution

  def call(resolution, _) do
    resolution
    |> Absinthe.Resolution.put_result(
      {:error, message: "Authentication failed", code: ecode(:account_login)}
    )

    #    IO.inspect %{resolution |
    #      errors: :auth_failed
    #    }
  end
end
