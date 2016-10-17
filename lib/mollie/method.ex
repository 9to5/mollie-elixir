defmodule Mollie.Method do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :description, :amount, :image]
  @type t :: %__MODULE__{id: binary, description: binary, amount: binary, image: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Method endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(method_id) do
    Base.get("methods/#{method_id}", __MODULE__)
  end
end
