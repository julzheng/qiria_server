defmodule Client.QiriaGraphQL.Schema do
  use Absinthe.Schema
  alias Client.QiriaGraphQL.{Mutations, Types, Queries}

  import_types(Mutations.AccountMutations)
  import_types(Queries.AccountQueries)
  import_types(Types.AccountTypes)

  query do
    import_fields(:user_query)
  end

  mutation do
    import_fields(:user_mutations)
  end

end