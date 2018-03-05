defmodule Mollie.Config do
  defstruct [:id, :api_key]
  @type t :: %__MODULE__{id: binary, api_key: binary}

  @moduledoc """
  This module defines the fields for the configuration
  """
end
