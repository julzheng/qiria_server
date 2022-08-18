defmodule Library.Utils.Collections do
  @moduledoc """
  This module define function that operate on collections,
  which is needed for the project but not available on elixir standard library
  """

  @doc """
  Merging struct of key, value (atom, string) with map of key, value (string, string).
  It is implemented due the impossibility of Map.merge(map1, map2) to
  combine map of (atom, string) with map of (string, string) on key parity of string and atom.

  ## Examples

      iex> Library.Utils.Collections(%Qiria.Application.User{email: nil,
                                                              fullname: nil,
                                                              password_hash: nil,
                                                              id: nil,
                                                              password: nil},
                                                                %{"email" => "julian@qiria.com",
                                                                "fullname" => "julian",
                                                                "password" => "easypass"})
            %Qiria.Application.User{email: "julian@qiria.com",
                                      fullname: "julian",
                                      password_hash: nil,
                                      id: nil,
                                      password: "easypass"}
  """
  def to_struct(kind, attrs) do
    struct = struct(kind)

    Enum.reduce(Map.to_list(struct), struct, fn {k, _}, acc ->
      case Map.fetch(attrs, Atom.to_string(k)) do
        {:ok, v} -> %{acc | k => v}
        :error -> acc
      end
    end)
  end

  def cast_struct(from_kind, to_kind) do
    from_kind
    |> Map.from_struct()
    |> Map.drop([:__meta__])
    |> (&struct(to_kind, &1)).()
  end
end
