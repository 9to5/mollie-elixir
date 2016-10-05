defmodule Mollie.PaymentsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/payments")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(.*)" <> (System.get_env("payment_id") || "PAYMENT_ID") <> "(.*)", "\\1PAYMENT_ID\\2")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get" do
    test "it returns an array of Mollie.Payment structs" do
      use_cassette "get" do
        response = Mollie.Payments.get
        assert {:ok, payments} = response
        assert payments |> Enum.at(0) |> Map.get(:id) == "PAYMENT_ID"
      end
    end
  end
end
