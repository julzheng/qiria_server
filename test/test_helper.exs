Mox.defmock(Qiria.AccountMock, for: Qiria.Account.Impl)
Application.put_env(:qiria, :impl, Qiria.AccountMock)

ExUnit.start()
