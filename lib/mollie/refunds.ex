defmodule Mollie.Refunds do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Refund]

  @moduledoc """
  This module defines the actions that can be taken on the Refunds endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get, do: Base.default_config |> get()

  @spec get(%Mollie.Config{}) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config) do
    Base.get("refunds", [%Mollie.Refund{}], config)
  end

  @spec get(binary) :: {:ok, t} | Error.t
  def get(payment_id), do: Base.default_config |> get(payment_id)

  @spec get(%Mollie.Config{}, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, payment_id) do
    Base.get("payments/#{payment_id}/refunds", [%Mollie.Refund{}], config)
  end
end
