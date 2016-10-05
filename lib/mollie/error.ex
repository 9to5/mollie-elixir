defmodule Mollie.Error do
  @moduledoc false

  defstruct [:reason, :code]
  @type t :: %__MODULE__{
    reason: binary,
    code: integer
  }

  def new(code, %{error: reason}) do
    %__MODULE__{
      reason: reason,
      code: code
    }
  end
  def new(code, %{error: reason, ok: false}) do
    %__MODULE__{
      reason: reason,
      code: code
    }
  end
  def new(code, reason) do
    %__MODULE__{
      reason: reason,
      code: code
    }
  end
end
