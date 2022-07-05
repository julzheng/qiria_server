defmodule Client.Web.UserController do
  use Client.Web, :controller

  alias Plug.Conn

  @spec check(Conn.t(), map()) :: Conn.t()
  def check(conn, params) do
    case Qiria.Account.check_email_duplicate?(params["email"]) do
      true ->
        conn
        |> put_view(Client.Web.JSONView)
        |> render("show.json",
          assigns: %{
            data: %{email_exist: true}
          }
        )

      false ->
        conn
        |> put_view(Client.Web.JSONView)
        |> render("show.json",
          assigns: %{
            data: %{email_exist: false}
          }
        )
    end
  end
end
