defmodule Mollie.Mandates do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Mandate]

  @moduledoc """
  This module defines the actions that can be taken on the Mandates endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(customer_id), do: Base.default_config |> get(customer_id)

  @spec get(%Mollie.Config{}, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, customer_id) do
    Base.get("customers/#{customer_id}/mandates", [%Mollie.Mandate{}], config)
  end
end
