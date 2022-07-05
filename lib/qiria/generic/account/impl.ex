defmodule Qiria.Account.Impl do
  @moduledoc false

  alias Qiria.Account.Application.User

  @callback register_account(User.t()) :: {:ok, User.t()} | {:error, :email_already_registered}
  @callback check_email_duplicate?(String.t()) :: boolean()
  @callback update_account(User.t(), map()) :: {:ok, User.t()} | {:error, :update_failed}
  @callback get_account(map(), String.t()) :: {:ok, User.t()} | {:error, :retrieval_failed}
end
