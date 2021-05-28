defmodule Mollie.MandatesTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/mandates")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing mandate_id" do
    test "it returns a Mollie.Mandate struct" do
      use_cassette "get" do
        customer_id = "CUSTOMER_ID"
        response = Mollie.Mandates.get(customer_id)
        assert {:ok, [mandate]} = response
        assert mandate.id == "MANDATE_ID"
      end
    end
  end
end
