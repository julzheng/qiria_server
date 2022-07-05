defmodule Client.QiriaGraphQL.Resolvers.AccountResolvers do
  alias Qiria.Account.Application

  def list_users(_parent, _args, _resolution) do
    #    IO.inspect(_resolution)
    {:ok,
     %Qiria.Account.Business.User{
       fullname: "User One",
       email: "userone@gmail.com"
     }}
  end

  def get_user_by_id(_parents, _args, %{context: %{current_user_id: current_user_id}}) do
    Qiria.Account.get_account(%{user_id: current_user_id}, "get_by_user_id")
  end

  def update_user(_parent, args, %{context: %{current_user_id: current_user_id}}) do
    Qiria.Account.update_account(%Application.User{id: current_user_id}, args)
  end
end
