defmodule Mollie.Customer do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :name, :email, :locale]
  @type t :: %__MODULE__{id: binary, name: binary, email: binary, locale: binary} # TODO: add metadata

  @moduledoc """
  This module defines the actions that can be taken on the Customer endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(customer_id) do
    Base.get("customers/#{customer_id}", __MODULE__)
  end

  @spec post(%Mollie.Customer{}) :: {:ok, any} | Error.t
  def post(customer) do
    data = customer
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers", data, __MODULE__)
  end

  @spec update(binary, %Mollie.Customer{}) :: {:ok, any} | Error.t
  def update(customer_id, customer) do
    data = customer
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers/#{customer_id}", data, __MODULE__)
  end
end
