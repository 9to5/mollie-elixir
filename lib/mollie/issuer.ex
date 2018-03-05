defmodule Mollie.Issuer do
  alias Mollie.Base
  alias Mollie.Error

  defstruct [:id, :name, :method]
  @type t :: %__MODULE__{id: binary, name: binary, method: binary}

  @moduledoc """
  This module defines the actions that can be taken on the Issuer endpoint.
  """

  @spec get(binary) :: {:ok, t} | Error.t
  def get(method_id), do: Base.default_config |> get(method_id)

  @spec get(%Mollie.Config{}, binary) :: {:ok, t} | Error.t
  def get(%Mollie.Config{} = config, method_id) do
    Base.get("issuers/#{method_id}", __MODULE__, config)
  end
end
