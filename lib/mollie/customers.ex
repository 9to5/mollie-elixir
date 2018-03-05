defmodule Mollie.Customers do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Customer]

  @moduledoc """
  This module defines the actions that can be taken on the Customers endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get, do: Base.default_config |> get()

  @spec get(%Mollie.Config{}) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config) do
    Base.get("customers", [%Mollie.Customer{}], config)
  end
end
