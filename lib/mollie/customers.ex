defmodule Mollie.Customers do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Customer]

  @endpoint "customers"

  @moduledoc """
  This module defines the actions that can be taken on the Customers endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get(@endpoint, [%Mollie.Customer{}])
  end
end
