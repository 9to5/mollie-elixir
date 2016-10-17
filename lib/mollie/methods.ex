defmodule Mollie.Methods do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Method]

  @moduledoc """
  This module defines the actions that can be taken on the Methods endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get("methods", [%Mollie.Method{}])
  end
end
