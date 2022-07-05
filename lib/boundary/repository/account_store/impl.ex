defmodule Qiria.Boundary.Repository.AccountStore.Impl do
  @moduledoc false

  alias Qiria.Account
  alias Qiria.Authnz
  alias Qiria.Domain

  @callback create_account(Domain.User.t()) ::
              {:ok, any()} | {:error, :email_is_not_unique} | {:error, :create_failed}
  @callback is_account_exist?(Authnz.Application.Credential.t()) :: boolean()
  @callback get_account_by(map(), String.t()) ::
              {:ok, any()} | {:error, :retrieval_failed}
  @callback update_account(Account.Application.User.t(), map()) :: {:ok, any()} | {:error, :update_failed}
end
