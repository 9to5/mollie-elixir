defmodule Mollie.Payment do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :amount, :description, :redirectUrl, :webhookUrl, :method, :metadata, :locale, :recurringType,
             :customerId, :mandateId, :subscriptionId, :issuer, :profileId, :testmode, :applicationFee, :status, :links,
             :mode, :createDatetime, :paidDatetime, :cancelledDatetime, :expiredDatetime, :expiryPeriod,
             :amountRefunded, :amountRemaining, :countryCode, :settlementId, :details]

  @type t :: %__MODULE__{id: binary, amount: binary, description: binary, redirectUrl: binary, webhookUrl: binary,
                         method: binary, metadata: %{Atom => binary}, locale: binary, recurringType: binary,
                         customerId: binary, mandateId: binary, subscriptionId: binary, issuer: binary,
                         profileId: binary, testmode: binary, applicationFee: binary, status: binary,
                         links: %{Atom => binary}, mode: binary, createDatetime: binary, paidDatetime: binary,
                         cancelledDatetime: binary, expiredDatetime: binary, expiryPeriod: binary,
                         amountRefunded: binary, amountRemaining: binary, countryCode: binary, settlementId: binary,
                         details: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Payment endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(payment_id), do: Base.default_config |> get(payment_id)

  @spec get(%Mollie.Config{}, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, payment_id) do
    Base.get("payments/#{payment_id}", __MODULE__, config)
  end

  @spec post(%Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(payment), do: Base.default_config |> post(payment)

  @spec post(%Mollie.Config{}, %Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(%Mollie.Config{} = config, payment) do
    data = payment
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("payments", data, __MODULE__, config)
  end

  @spec post(binary, %Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(customer_id, payment), do: Base.default_config |> post(customer_id, payment)

  @spec post(%Mollie.Config{}, binary, %Mollie.Payment{}) :: {:ok, any} | Error.t
  def post(%Mollie.Config{} = config, customer_id, payment) do
    data = payment
           |> Map.from_struct
           |> Enum.reject(fn {_x, y} -> y == nil end)
    Base.post("customers/#{customer_id}/payments", data, __MODULE__, config)
  end
end
