defmodule Client.Web.JSONView do
  use Client.Web, :view

  def render("show.json", %{assigns: assigns}) do
    %{meta: Map.get(assigns, :meta), data: Map.get(assigns, :data)}
    # drop null value entry
    |> Enum.filter(fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end
end
