defmodule Mollie.MethodsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/methods")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get" do
    test "it returns an array of Mollie.Method structs" do
      use_cassette "get" do
        response = Mollie.Methods.get
        assert {:ok, methods} = response
        assert methods |> Enum.at(0) |> Map.get(:id) == "ideal"
      end
    end
  end
end
