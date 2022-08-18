defmodule Qiria.Authnz.Impl do
  @moduledoc false

  alias Qiria.Authnz.Application.Credential
  alias Qiria.Authnz.Application.AuthnPass
  alias Plug.Conn

  @callback authenticate(Credential.t(), Conn.t()) ::
              {:ok, AuthnPass.t()} | {:error, :authn_failed}
end
