defmodule Mollie.RefundsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/refunds")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get" do
    test "it returns an array of Mollie.Refund structs" do
      use_cassette "get" do
        response = Mollie.Refunds.get
        assert {:ok, [refund]} = response
        assert refund.id == "REFUND_ID"
      end
    end
  end

  describe "get within payments" do
    test "it returns an array of Mollie.Refund structs" do
      use_cassette "payment_get" do
        payment_id = "PAYMENT_ID"
        response = Mollie.Refunds.get(payment_id)
        assert {:ok, [refund]} = response
        assert refund.id == "REFUND_ID"
      end
    end
  end
end
