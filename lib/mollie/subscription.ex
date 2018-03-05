defmodule Mollie.Subscription do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :amount, :times, :interval, :startDate, :description, :method, :webhookUrl, :customerId, :mode,
             :status, :createdDatetime, :cancelledDatetime, :links]
  @type t :: %__MODULE__{id: binary, amount: binary, times: binary, interval: binary, startDate: binary,
                         description: binary, method: binary, webhookUrl: binary, customerId: binary, mode: binary,
                         status: binary, createdDatetime: binary, cancelledDatetime: binary, links: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Subscription endpoint.
  """

  @spec get(binary, binary) :: {:ok, t} | Error.t
  def get(customer_id, subscription_id), do: Base.default_config |> get(customer_id, subscription_id)

  @spec get(%Mollie.Config{}, binary, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, customer_id, subscription_id) do
    Base.get("customers/#{customer_id}/subscriptions/#{subscription_id}", __MODULE__, config)
  end

  @spec post(binary, %Mollie.Subscription{}) :: {:ok, any} | Error.t
  def post(customer_id, subscription), do: Base.default_config |> post(customer_id, subscription)

  @spec post(%Mollie.Config{}, binary, %Mollie.Subscription{}) :: {:ok, any} | Error.t
  def post(%Mollie.Config{} = config, customer_id, subscription) do
    data = subscription
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers/#{customer_id}/subscriptions", data, __MODULE__, config)
  end

  @spec cancel(binary, binary) :: {:ok, t} | Error.t
  def cancel(customer_id, subscription_id), do: Base.default_config |> cancel(customer_id, subscription_id)

  @spec cancel(%Mollie.Config{}, binary, binary) :: {:ok, t} | Error.t
  def cancel(%Mollie.Config{} = config, customer_id, subscription_id) do
    Base.delete("customers/#{customer_id}/subscriptions/#{subscription_id}", config)
  end
end
