defmodule Client.QiriaGraphQL.Types.AccountTypes do
  use Absinthe.Schema.Notation
  import_types(Absinthe.Type.Custom)

  object :user do
    field(:id, :id)
    field(:fullname, :string)
    field(:email, :string)
    field(:inserted_at, :datetime)
    field(:updated_at, :datetime)
  end
end
