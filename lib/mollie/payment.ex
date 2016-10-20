defmodule Mollie.Payment do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :amount, :description, :redirectUrl, :webhookUrl, :method, :metadata, :locale, :recurringType,
             :customerId, :mandateId, :status]
  @type t :: %__MODULE__{id: binary, amount: binary, description: binary, redirectUrl: binary, webhookUrl: binary,
                         method: binary, locale: binary, recurringType: binary, customerId: binary, status: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Payment endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(payment_id) do
    Base.get("payments/#{payment_id}", __MODULE__)
  end

  @spec post(%Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(payment) do
    data = payment
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("payments", data, __MODULE__)
  end

  @spec post(binary, %Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(customer_id, payment) do
    data = payment
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers/#{customer_id}/payments", data, __MODULE__)
  end
end
