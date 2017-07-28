defmodule Mollie.Subscriptions do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Subscription]

  @moduledoc """
  This module defines the actions that can be taken on the Subscriptions endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(customer_id) do
    Base.get("customers/#{customer_id}/subscriptions", [%Mollie.Subscription{}])
  end
end
