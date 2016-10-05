defmodule Mollie.MethodTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/method")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing method_id" do
    test "it returns a Mollie.Method struct" do
      use_cassette "get" do
        response = Mollie.Method.get("ideal")
        assert {:ok, method} = response
        assert method.id == "ideal"
      end
    end
  end

  describe "get with a non-existing method_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        response = Mollie.Method.get("MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The payment method is invalid"}}
      end
    end
  end
end
