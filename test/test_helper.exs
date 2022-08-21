Mox.defmock(Qiria.AccountMock, for: Qiria.Account.Impl)
Application.put_env(:qiria, :impl, Qiria.AccountMock)

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Infrastructure.Persistence.Repo, :manual)
