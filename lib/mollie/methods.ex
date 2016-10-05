defmodule Mollie.Methods do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Method]

  @endpoint "methods"

  @moduledoc """
  This module defines the actions that can be taken on the Methods endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get(@endpoint, [%Mollie.Method{}])
  end
end
