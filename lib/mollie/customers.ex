defmodule Mollie.Customers do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Customer]

  @moduledoc """
  This module defines the actions that can be taken on the Customers endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get("customers", [%Mollie.Customer{}])
  end
end
