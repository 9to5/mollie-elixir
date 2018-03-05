defmodule Mollie.Payments do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Payment]

  @moduledoc """
  This module defines the actions that can be taken on the Payments endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get, do: Base.default_config |> get()

  @spec get(%Mollie.Config{}) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config) do
    Base.get("payments", [%Mollie.Payment{}], config)
  end

  @spec get(binary) :: {:ok, t} | Error.t
  def get(customer_id), do: Base.default_config |> get(customer_id)

  @spec get(%Mollie.Config{}, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, customer_id) do
    Base.get("customers/#{customer_id}/payments", [%Mollie.Payment{}], config)
  end
end
