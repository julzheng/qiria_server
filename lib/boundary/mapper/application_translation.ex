defmodule Qiria.Boundary.Mapper.ApplicationTranslation do
  @moduledoc false

  @spec to_user(Plug.Conn.params()) :: Qiria.Account.Application.User.t()
  def to_user(%Plug.Conn{body_params: body_params}) do
    body_params
    |> (&Library.Utils.Collections.to_struct(Qiria.Account.Application.User, &1)).()
  end

  @spec to_credential(Plug.Conn.params()) :: Qiria.Authnz.Application.Credential.t()
  def to_credential(%Plug.Conn{body_params: body_params}) do
    body_params
    |> (&Library.Utils.Collections.to_struct(Qiria.Authnz.Application.Credential, &1)).()
  end
end
