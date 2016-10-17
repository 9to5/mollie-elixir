defmodule Mollie.Mandate do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :method, :consumerName, :consumerAccount, :consumerBic, :signatureDate, :mandateReference, :status]
  @type t :: %__MODULE__{id: binary, method: binary, consumerName: binary, consumerAccount: binary, consumerBic: binary,
                         signatureDate: binary, mandateReference: binary, status: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Mandate endpoint.
  """

  @spec get(binary, binary) :: {:ok, t} | Error.t
  def get(customer_id, mandate_id) do
    Base.get("customers/#{customer_id}/mandates/#{mandate_id}", __MODULE__)
  end

  @spec post(binary, %Mollie.Mandate{}) :: {:ok, any} | Error.t
  def post(customer_id, mandate) do
    data = mandate
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers/#{customer_id}/mandates", data, __MODULE__)
  end

  @spec revoke(binary, binary) :: {:ok, t} | Error.t
  def revoke(customer_id, mandate_id) do
    Base.delete("customers/#{customer_id}/mandates/#{mandate_id}")
  end
end
