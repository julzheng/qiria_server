defmodule Qiria.Features.RegistrationTest do
  use Cabbage.Feature, async: false, file: "registration.feature"
  use Qiria.RepoCase

  alias Qiria.Account.Application.User

  setup do
    on_exit fn ->
      IO.puts "Scenario completed, cleanup stuff"
    end
    Application.put_env(:qiria, :impl, Qiria.Account.Application.DefaultImpl)
  end

  defgiven ~r/^I have registered using "(?<email>[^"]+)"$/, %{email: email}, state do
    user = %User{fullname: "Joe", email: email, password: "password"}
    assert {:ok, _} = Qiria.Account.register_account(user)
    {:ok, %{user: user}}
  end

  defwhen ~r/^I'm signing up using "(?<registered_email>[^"]+)"$/, %{registered_email: registered_email}, state do
    user = %User{fullname: "Joe", email: registered_email, password: "password"}
    {:error, msg} = Qiria.Account.register_account(user)
    {:ok, %{error_msg: msg}}
  end

  defthen ~r/^I shouldn't be able to do so$/, _, state do
    assert state.error_msg == :email_is_already_registered
  end
end