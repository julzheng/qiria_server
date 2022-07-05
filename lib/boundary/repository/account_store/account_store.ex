defmodule Qiria.Boundary.Repository.AccountStore do
  @moduledoc false

  @behaviour Qiria.Boundary.Repository.AccountStore.Impl

  alias Infrastructure.Persistence.MariaDB.Schema
  alias Qiria.Account
  alias Qiria.Authnz
  alias Qiria.Domain

  @spec create_account(Domain.User.t()) ::
          {:ok, any()} | {:error, :email_is_not_unique} | {:error, :create_failed}
  def create_account(user) do
    user
    |> impl().create_account()
  end

  @spec is_account_exist?(map()) :: boolean()
  def is_account_exist?(credentials) do
    credentials
    |> impl().is_account_exist?()
  end

  @spec get_account_by(map(), String.t()) ::
          {:ok, any()} | {:error, :retrieval_failed}
  def get_account_by(attrs, condition) do
    attrs
    |> impl().get_account_by(condition)
  end

  @spec update_account(Account.Application.User.t(), map()) ::
          {:ok, any()} | {:error, :update_failed}
  def update_account(user, attrs) do
    user
    |> impl().update_account(attrs)
  end

  defp impl do
    Application.get_env(
      :qiria,
      :account_store,
      Infrastructure.Persistence.MariaDB.MariaDBImpl.Account
    )
  end
end
