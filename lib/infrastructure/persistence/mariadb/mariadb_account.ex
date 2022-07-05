defmodule Infrastructure.Persistence.MariaDB.MariaDBImpl.Account do
  alias Infrastructure.Persistence.Repo

  import Ecto.Query, only: [from: 2]

  @behaviour Qiria.Boundary.Repository.AccountStore.Impl

  alias Infrastructure.Persistence.Schema
  alias Qiria.Account
  alias Qiria.Authnz
  alias Qiria.Domain

  @impl true
  @spec create_account(Domain.User.t()) ::
          {:ok, any()} | {:error, :email_is_not_unique} | {:error, :create_failed}
  def create_account(user) do
    user_schema =
      user
      |> Map.drop([:password, :email, :password_hash])
      |> (&struct!(Schema.User, &1)).()

    auth_schema =
      user
      |> Map.drop([:fullname, :password])
      |> (&struct!(Schema.Auth, &1)).()

    attrs = auth_schema |> Map.from_struct() |> Map.drop([:__meta__])

    try do
      Ecto.Multi.new()
      |> Ecto.Multi.insert(:insert_user, user_schema)
      |> Ecto.Multi.insert(:insert_auth, fn %{insert_user: user} ->
        Ecto.build_assoc(user, :auth, attrs)
      end)
      |> Repo.transaction()
      |> case do
        {:ok, result} ->
          {:ok, result}

        {:error, _, _, _} ->
          {:error, :create_failed}
      end
    rescue
      _ in Ecto.ConstraintError ->
        {:error, :email_is_not_unique}
    end
  end

  @impl true
  @spec is_account_exist?(map()) :: boolean()
  def is_account_exist?(credentials) do
    Repo.exists?(from(u in Schema.Auth, where: u.email == ^credentials.email))
  end

  @impl true
  @spec get_account_by(map(), String.t()) ::
          {:ok, any()} | {:error, :retrieval_failed}
  def get_account_by(attrs, condition) do
    case condition do
      "email" ->
        case Repo.get_by(Schema.Auth, email: attrs.email) do
          auth ->
            {:ok, auth}

          nil ->
            {:error, :retrieval_failed}
        end

      "user_id" ->
        case Repo.get_by(Schema.Auth, user_id: attrs.user_id) do
          auth ->
            {:ok, auth}

          nil ->
            {:error, :retrieval_failed}
        end
    end
  end

  @imp true
  @spec update_account(Application.User.t(), map()) :: {:ok, any()} | {:error, :update_failed}
  def update_account(user, attrs) do
    Schema.User
    |> Repo.get(user.id)
    |> case do
      nil ->
        {:error, :update_failed}

      specified_user ->
        user_changeset = specified_user |> Schema.User.create_changeset(attrs)

        auth_changeset =
          specified_user
          |> Repo.preload(:auth)
          |> Map.get(:auth)
          |> Schema.Auth.create_changeset(attrs)

        Ecto.Multi.new()
        |> Ecto.Multi.update(:update_user, user_changeset)
        |> Ecto.Multi.update(:update_auth, auth_changeset)
        |> Repo.transaction()
    end
  end
end
