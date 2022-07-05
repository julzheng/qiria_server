defmodule Client.Web.APIAuthErrorHandler do
  use Client.Web, :controller
  alias Plug.Conn

  @spec call(Conn.t(), :not_authenticated) :: Conn.t()
  def call(conn, :not_authenticated) do
    conn
    |> put_status(401)
    |> json(%{meta: %{message: "Unauthenticated request is prohibited"}})
  end
end