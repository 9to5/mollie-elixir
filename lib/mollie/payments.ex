defmodule Mollie.Payments do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Payment]

  @endpoint "payments"

  @moduledoc """
  This module defines the actions that can be taken on the Payments endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get(@endpoint, [%Mollie.Payment{}])
  end
end
