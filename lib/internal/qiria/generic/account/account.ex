defmodule Qiria.Account do
  @moduledoc """
  Main API for Qiria Account Application
  """

  alias Qiria.Account.Application.DefaultImpl
  alias Qiria.Account.Application.User

  @spec register_account(User.t()) ::
          {:ok, User.t()} | {:error, :email_is_already_registered}
  def register_account(user) do
    current_impl().register_account(user)
  end

  @spec check_email_duplicate?(String.t()) :: boolean()
  def check_email_duplicate?(email) do
    current_impl().check_email_duplicate?(email)
  end

  @spec update_account(User.t(), map()) :: {:ok, User.t()} | {:error, :update_failed}
  def update_account(user, attrs) do
    current_impl().update_account(user, attrs)
  end

  @spec get_account(map(), String.t()) :: {:ok, User.t()} | {:error, :retrieval_failed}
  def get_account(attrs, condition) do
    current_impl().get_account(attrs, condition)
  end

  @doc false
  defp current_impl do
    Application.get_env(:qiria, :impl, DefaultImpl)
  end
end
