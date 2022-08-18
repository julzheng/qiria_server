defmodule Qiria.Authnz do
  @moduledoc """
  Main API for Qiria Authnz Application
  """

  alias Qiria.Authnz.Application.DefaultImpl
  alias Plug.Conn

  @spec authenticate(Credential.t(), Conn.t()) :: {:ok, AuthnPass.t()} | {:error, :authn_failed}
  def authenticate(credential, conn) do
    current_impl().authenticate(credential, conn)
  end

  @doc false
  def current_impl do
    Application.get_env(:qiria, :impl, DefaultImpl)
  end
end
