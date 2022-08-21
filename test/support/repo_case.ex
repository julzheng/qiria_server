defmodule Qiria.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Infrastructure.Persistence.Repo

      import Ecto
      import Ecto.Query
      import Qiria.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Infrastructure.Persistence.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Infrastructure.Persistence.Repo, {:shared, self()})
    end

    :ok
  end
end