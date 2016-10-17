defmodule Mollie.Payments do
  alias Mollie.Base
  alias Mollie.Error

  @type t :: [Mollie.Payment]

  @moduledoc """
  This module defines the actions that can be taken on the Payments endpoint.
  """

  @spec get :: {:ok, t} | Error.t
  def get do
    Base.get("payments", [%Mollie.Payment{}])
  end
end
