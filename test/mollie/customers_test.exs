defmodule Mollie.CustomersTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/customers")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get" do
    test "it returns an array of Mollie.Customer structs" do
      use_cassette "get" do
        response = Mollie.Customers.get
        assert {:ok, customers} = response
        assert customers |> Enum.at(0) |> Map.get(:id) == "CUSTOMER_ID"
      end
    end
  end
end
