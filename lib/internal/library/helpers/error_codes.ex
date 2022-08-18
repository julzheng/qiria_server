defmodule Library.Helpers.ErrorCodes do
  @moduledoc """
  error code map for qiria
  """
  @default_base 4000
  @changeset_base 4100
  @throttle_base 4200
  @account_base 4300

  # account error code
  def ecode(:account_login), do: @account_base + 1
  def ecode, do: @default_base

  # changeset error code
  def ecode(:changeset), do: @changeset_base + 2

  # default errors
  def ecode(:custom), do: @default_base + 1

end
