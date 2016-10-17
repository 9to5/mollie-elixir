defmodule Mollie.Refund do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :amount, :description]
  @type t :: %__MODULE__{id: binary, amount: binary, description: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Refund endpoint.
  """

  @spec get(binary, binary) :: {:ok, t} | Error.t
  def get(payment_id, refund_id) do
    Base.get("payments/#{payment_id}/refunds/#{refund_id}", __MODULE__)
  end

  @spec post(binary, %Mollie.Refund{}) :: {:ok, any} | Error.t
  def post(payment_id, mandate) do
    data = mandate
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("payments/#{payment_id}/refunds", data, __MODULE__)
  end

  @spec cancel(binary, binary) :: {:ok, t} | Error.t
  def cancel(payment_id, refund_id) do
    Base.delete("payments/#{payment_id}/refunds/#{refund_id}")
  end
end
