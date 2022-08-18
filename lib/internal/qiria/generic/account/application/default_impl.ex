defmodule Qiria.Account.Application.DefaultImpl do
  @behaviour Qiria.Account.Application.Impl

  import Ecto.Changeset

  alias Qiria.Account
  alias Qiria.Account.Application.User
  alias Qiria.Boundary.Repository.AccountStore

  @impl true
  @spec register_account(User.t()) :: {:ok, User.t()} | {:error, String.t()}
  def register_account(user) do
    with {:ok, _} <- validate_when_register(user),
         {false, _} <- is_existing_account?(user) do
      user
      |> Map.from_struct()
      |> Map.drop([:id])
      |> Account.Business.User.register()
      |> Map.put(:password_hash, Argon2.hash_pwd_salt(user.password))
      |> Map.from_struct()
      |> AccountStore.create_account()
      |> case do
        {:ok, mp} ->
          {:ok, %User{id: mp.insert_user.id}}

        {:error, :create_failed} ->
          {:error, :create_failed}
      end
    else
      {:error, :email_is_already_registered} -> {:error, :email_is_already_registered}
      {:error, _} -> {:error, :validation_failed}
    end
  end

  @impl true
  @spec check_email_duplicate?(String.t()) :: boolean()
  def check_email_duplicate?(email) do
    case AccountStore.is_account_exist?(%{email: email}) do
      true ->
        if Qiria.Account.Business.User.is_email_exist?(%Qiria.Account.Business.User{email: email}) ==
             true do
          true
        end

      false ->
        if Qiria.Account.Business.User.is_email_exist?(%Qiria.Account.Business.User{}) == false do
          false
        end
    end
  end

  @impl true
  @spec update_account(User.t(), map()) :: {:ok, User.t()} | {:error, :update_failed}
  def update_account(user, attrs) do
    attrs = compute_password_hash_when_password_exist(attrs)

    case AccountStore.update_account(user, attrs) do
      {:ok, mp} ->
        {:ok, %User{id: mp.update_user.id}}

      {:error, mp} ->
        {:error, :update_failed}
    end
  end

  @impl true
  @spec get_account(map(), String.t()) :: {:ok, User.t()} | {:error, :retrieval_failed}
  def get_account(attrs, condition) do
    case condition do
      "get_by_user_id" -> AccountStore.get_account_by(attrs, "user_id")
    end
  end

  defp compute_password_hash_when_password_exist(attrs) do
    if Map.has_key?(attrs, :password) do
      attrs |> Map.put(:password_hash, Argon2.hash_pwd_salt(attrs[:password]))
    else
      attrs
    end
  end

  @spec validate_when_register(User.t()) :: Changeset.t()
  defp validate_when_register(user) do
    %Qiria.Account.Application.User{}
    |> change(Map.from_struct(user))
    |> validate_required([:email, :password])
    |> apply_action(:validate)
  end

  defp is_existing_account?(user) do
    user
    |> AccountStore.is_account_exist?()
    |> case do
      true -> {:error, :email_is_already_registered}
      false -> {false, :email_never_registered}
    end
  end
end
