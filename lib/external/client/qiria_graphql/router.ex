defmodule Client.QiriaGraphQL.Router do
  use Phoenix.Router
  #  use Plug.Debugger

  pipeline :graphql do
    plug(Plug.Logger)
    plug(Client.Web.APIAuthPlug)
    plug(Client.QiriaGraphQL.Plugs.Context)
  end

  scope "/api" do
    pipe_through(:graphql)

    forward("/graphql", Absinthe.Plug, schema: Client.QiriaGraphQL.Schema)

    if Mix.env() == :dev do
      forward(
        "/graphiql",
        Absinthe.Plug.GraphiQL,
        schema: Client.QiriaGraphQL.Schema
      )
    end
  end
end
