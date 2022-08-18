defmodule Client.Web.LoginController do
  use Client.Web, :controller

  alias Client.Web.APIAuthPlug
  alias Plug.Conn

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, _params) do
    with {:ok, authn_pass} <-
           conn
           |> Qiria.Boundary.Mapper.ApplicationTranslation.to_credential()
           |> Qiria.Authnz.authenticate(conn) do
      conn
      |> put_status(201)
      |> put_view(Client.Web.JSONView)
      |> render("show.json", assigns: %{data: authn_pass |> Map.from_struct()})
    else
      {:error, _} ->
        conn
        |> put_status(422)
        |> put_view(Client.Web.JSONView)
        |> render("show.json", assigns: %{meta: %{message: :authn_failed}})
    end
  end
end
