defmodule Client.Web.RegistrationController do
  use Client.Web, :controller

  alias Plug.Conn

  @spec create(Conn.t(), map()) :: Conn.t()
  def create(conn, _params) do
    with {:ok, _user} <-
           conn
           |> Qiria.Boundary.Mapper.ApplicationTranslation.to_user()
           |> Qiria.Account.register_account(),
         {:ok, authn_pass} <-
           conn
           |> Qiria.Boundary.Mapper.ApplicationTranslation.to_credential()
           |> Qiria.Authnz.authenticate(conn) do
      conn
      |> put_status(201)
      |> put_view(Client.Web.JSONView)
      |> render("show.json",
        assigns: %{message: :registration_successful, data: authn_pass |> Map.from_struct()}
      )
    else
      {:error, :email_is_already_registered} ->
        conn
        |> put_status(422)
        |> put_view(Client.Web.JSONView)
        |> render("show.json", assigns: %{message: :email_is_already_registered})

      {:error, :validation_failed} ->
        conn
        |> put_status(422)
        |> put_view(Client.Web.JSONView)
        |> render("show.json", assigns: %{message: :validation_failed})

      {:error, reason} ->
        conn
        |> put_status(500)
        |> put_view(Client.Web.JSONView)
        |> render("show.json", assigns: %{message: reason})
    end
  end
end
