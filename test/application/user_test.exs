defmodule Qiria.Account.Application.UserTest do
  use ExUnit.Case, async: true

  alias Qiria.Account.Application.User

  import Mox

  setup :verify_on_exit!

  describe "register_account/1" do
    test "Success: account creation" do
      Qiria.AccountMock
      |> expect(
           :register_account,
           fn _user ->
             {:ok, %User{id: 1}}
           end
         )

      assert {:ok, _} = Qiria.Account.register_account(
               %User{fullname: "Joe", email: "joe@email.com", password: "password"}
             )
    end

    test "Failed: failed creation" do
      Qiria.AccountMock
      |> expect(
           :register_account,
           fn _user ->
             {:error, :create_failed}
           end
         )

      assert {:error, :create_failed} = Qiria.Account.register_account(
               %User{fullname: "Joe", email: "joe@email.com", password: "password"}
             )
    end

    test "Failed: email duplicate" do
      Qiria.AccountMock
      |> expect(
           :register_account,
           fn _user ->
             {:error, :email_is_already_registered}
           end
         )

      assert {:error, :email_is_already_registered} = Qiria.Account.register_account(
               %User{fullname: "Joe", email: "joe@email.com", password: "password"}
             )
    end
  end

  describe "check_email_duplicate?/1" do
    test "Success: no duplicate" do
      Qiria.AccountMock
      |> expect(
           :check_email_duplicate?,
           fn _email ->
             true
           end
         )

      assert true = Qiria.Account.check_email_duplicate?(
               "joe@email.com"
             )
    end

    test "Failed: duplicate found" do
      Qiria.AccountMock
      |> expect(
           :check_email_duplicate?,
           fn _email ->
             false
           end
         )

      refute Qiria.Account.check_email_duplicate?(
               "joe@email.com"
             )
    end
  end

  describe "update_account/2" do
    test "Success: account updated" do
      Qiria.AccountMock
      |> expect(
           :update_account,
           fn (_user, _attrs) ->
             {:ok, %User{id: 1}}
           end
         )

      assert {:ok, _} = Qiria.Account.update_account(
               %User{id: 1},
               %{email: "joe_email_changed@email.com"}
             )
    end

    test "Failed: account update failed" do
      Qiria.AccountMock
      |> expect(
           :update_account,
           fn (_user, _attrs) ->
             {:error, :update_failed}
           end
         )

      assert {:error, :update_failed} = Qiria.Account.update_account(
               %User{id: 1},
               %{email: "joe_email_changed@email.com"}
             )
    end
  end

  describe "get_account/2" do
    test "Success: account retrieved" do
      Qiria.AccountMock
      |> expect(
           :get_account,
           fn (_attrs, _condition) ->
             {:ok, %User{id: 1, fullname: "Joe", email: "joe@email.com"}}
           end
         )

      assert {:ok, _} = Qiria.Account.get_account(
               %{user_id: 1},
               "get_by_user_id"
             )
    end

    test "Failed: account cannot be retrieved" do
      Qiria.AccountMock
      |> expect(
           :get_account,
           fn (_attrs, _condition) ->
             {:error, :retrieval_failed}
           end
         )

      assert {:error, _} = Qiria.Account.get_account(
               %{user_id: -1},
               "get_by_user_id"
             )
    end
  end
end