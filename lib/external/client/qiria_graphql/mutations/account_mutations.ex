defmodule Client.QiriaGraphQL.Mutations.AccountMutations do
  use Absinthe.Schema.Notation
  alias Client.QiriaGraphQL.Resolvers, as: R
  alias Client.QiriaGraphQL.Middlewares, as: M

  object :user_mutations do
    @desc "update an user"
    field :update_user, :user do
      arg(:email, :string)
      arg(:password, :string)

      middleware(M.Authn)

      resolve(&R.AccountResolvers.update_user/3)
    end
  end
end
