defmodule Mollie.RefundTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/refund")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing refund_id" do
    test "it returns a Mollie.Refund struct" do
      use_cassette "get" do
        payment_id = "PAYMENT_ID"
        refund_id = "REFUND_ID"

        response = Mollie.Refund.get(payment_id, refund_id)
        assert {:ok, refund} = response
        assert refund.id == "REFUND_ID"
      end
    end
  end

  describe "get with a non-existing refund_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        payment_id = "PAYMENT_ID"

        response = Mollie.Refund.get(payment_id, "MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The refund id is invalid"}}
      end
    end
  end

  describe "post new refund" do
    test "it returns a Mollie.Refund struct" do
      use_cassette "post" do
        payment_id = "PAYMENT_ID"
        refund = %Mollie.Refund{amount: "0.01", description: "refund"}
        response = Mollie.Refund.post(payment_id, refund)
        assert {:ok, refund} = response
        assert refund.id == "REFUND_ID"
      end
    end
  end

  describe "revoke with an existing refund_id" do
    test "it ok" do
      use_cassette "delete" do
        payment_id = "PAYMENT_ID"
        refund_id = "REFUND_ID"

        response = Mollie.Refund.cancel(payment_id, refund_id)
        assert {:ok, _refund} = response
      end
    end
  end
end
