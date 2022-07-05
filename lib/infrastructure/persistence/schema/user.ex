defmodule Infrastructure.Persistence.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          __meta__: Ecto.Schema.Metadata.t(),
          id: integer | nil,
          fullname: String.t() | nil,
          avatar: String.t() | nil,
          inserted_at: DateTime.t() | nil,
          updated_at: DateTime.t() | nil,
          deleted_at: DateTime.t() | nil
        }
  schema "users" do
    field(:fullname, :string)
    field(:avatar, :string)
    field(:deleted_at, :utc_datetime_usec)
    has_one(:auth, Infrastructure.Persistence.Schema.Auth)

    timestamps(type: :utc_datetime_usec)
  end

  def create_changeset(user, attrs) do
    user
    |> cast(attrs, [:fullname, :avatar])
  end
end
