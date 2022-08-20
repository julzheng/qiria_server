defmodule Qiria.Account.Business.UserTest do
  use ExUnit.Case

  alias Qiria.Account.Business.User

  describe "is_email_exist/1" do
    test "Email has not been registered" do
      user = %User{email: "test@test.com"}

      assert User.is_email_exist?(user) == true

    end

    test "Email has been registered" do
      user = %User{}

      refute User.is_email_exist?(user) == true
    end
  end
end
