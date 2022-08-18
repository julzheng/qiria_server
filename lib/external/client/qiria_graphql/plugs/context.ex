defmodule Client.QiriaGraphQL.Plugs.Context do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  def build_context(conn) do
    if Application.get_env(:qiria, :env) == :dev && Application.get_env(:qiria, :graphql_auth) == :dev do
      with [access_token | _] <- get_req_header(conn, "authorization"),
           {:ok, current_auth} <- authorize(conn) do
        %{
          current_auth_id: current_auth.id,
          current_user_id: current_auth.user_id,
          access_token: access_token
        }
      else
        _ ->
          %{
            current_user_id: Application.get_env(:qiria, :LOGGED_IN_USER_ID),
            access_token: "dev_passed"
          }
      end
    else
      with [access_token | _] <- get_req_header(conn, "authorization"),
           {:ok, current_auth} <- authorize(conn) do
        %{
          current_auth_id: current_auth.id,
          current_user_id: current_auth.user_id,
          access_token: access_token
        }
      else
        _ -> conn
      end
    end
  end

  defp authorize(conn) do
    config = Pow.Plug.fetch_config(conn)

    case conn
         |> Client.Web.APIAuthPlug.fetch(config) do
      {_, nil} ->
        {:error, :auth_not_found}

      {_, auth} ->
        {:ok, auth}
    end
  end
end
