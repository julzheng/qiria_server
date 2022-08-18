defmodule Infrastructure.Persistence.Schema.Auth do
  use Ecto.Schema

  use Pow.Ecto.Schema,
    user_id_field: :email,
    password_hash_methods: {&Argon2.hash_pwd_salt/1, &Argon2.verify_pass/2}

  import Ecto.Changeset

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          email: String.t() | nil,
          password_hash: String.t() | nil,
          deleted_at: DateTime.t() | nil,
          user_id: integer | nil
        }
  schema "auths" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:deleted_at, :utc_datetime_usec)
    belongs_to(:user, Infrastructure.Persistence.Schema.User)

    pow_user_fields()

    timestamps(type: :utc_datetime_usec)
  end

  def create_changeset(auth, attrs) do
    auth
    |> cast(attrs, [:email, :password_hash])
    |> unique_constraint(:email)
  end

  #  def changeset(user, params \\ %{}) do
  #    user
  #    |> cast(params, [:name, :email, :age])
  #    |> validate_required([:name, :email])
  #    |> validate_format(:email, ~r/@/)
  #    |> validate_inclusion(:age, 18..100)
  #    |> unique_constraint(:email)
  #  end
end
