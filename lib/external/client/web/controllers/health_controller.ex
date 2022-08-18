defmodule Client.Web.HealthController do
  use Client.Web, :controller

  def show(conn, _params) do
    conn
    |> put_view(Client.Web.JSONView)
    |> render("show.json",
      assigns: %{
        meta: %{message: nil},
        data: %{science: :haha}
      }
    )
  end
end
