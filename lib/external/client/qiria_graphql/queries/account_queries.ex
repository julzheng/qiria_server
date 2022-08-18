defmodule Client.QiriaGraphQL.Queries.AccountQueries do
  use Absinthe.Schema.Notation
  alias Client.QiriaGraphQL.Resolvers, as: R
  alias Client.QiriaGraphQL.Middlewares, as: M

  object :user_query do
    @desc "Get all users"
    field :users, list_of(:user) do
      middleware(M.Authn)
      resolve(&R.AccountResolvers.list_users/3)
    end

    @desc "Get user by id"
    field :user, :user do
      arg(:id, non_null(:id))

      middleware(M.Authn)
      resolve(&R.AccountResolvers.get_user_by_id/3)
    end
  end
end
