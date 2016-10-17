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

  @spec post(binary, binary, binary) :: {:ok, any} | Error.t
  def post(name, email, locale) do
    Base.post("customers", [{:name, name}, {:email, email}, {:locale, locale}], __MODULE__)
  end
end
