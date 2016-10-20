defmodule Mollie.PaymentTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/payment")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing payment_id" do
    test "it returns a Mollie.Payment struct" do
      use_cassette "get" do
        payment_id = "PAYMENT_ID"

        response = Mollie.Payment.get(payment_id)
        assert {:ok, payment} = response
        assert payment.id == "PAYMENT_ID"
        assert payment.links == %{paymentUrl: "https://www.mollie.com/paymentscreen/ideal/select-issuer/xxxxx",
                                  redirectUrl: "http://redirectUrl.com", webhookUrl: "http://webhookUrl.com"}
      end
    end
  end

  describe "get with a non-existing payment_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        response = Mollie.Payment.get("MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The payment id is invalid"}}
      end
    end
  end

  describe "post new payment" do
    test "it returns a Mollie.Payment struct" do
      use_cassette "post" do
        payment = %Mollie.Payment{amount: "100.00", description: "description", redirectUrl: "http://redirectUrl.com",
                                  webhookUrl: "http://webhookUrl.com", method: "ideal", customerId: "CUSTOMER_ID"}
        response = Mollie.Payment.post(payment)
        assert {:ok, payment} = response
        assert payment.id == "PAYMENT_ID"
      end
    end

    test "performs an invalid Mollie.Payment" do
      use_cassette "post_invalid" do
        payment = %Mollie.Payment{}
        response = Mollie.Payment.post(payment)
        assert {:error, %Mollie.Error{code: 422, reason: "The amount is lower than the minimum"}} = response
      end
    end

    test "a recurring Mollie.Payment" do
      use_cassette "post_recurring" do
        payment = %Mollie.Payment{amount: "100.00", description: "description", recurringType: "recurring",
                                  customerId: "CUSTOMER_ID"}
        response = Mollie.Payment.post(payment)
        assert {:ok, payment} = response
        assert payment.id == "PAYMENT_ID"
      end
    end
  end
  describe "post new customer/:id/payment" do
    test "it returns a Mollie.Payment struct" do
      use_cassette "customer_post" do
        payment = %Mollie.Payment{amount: "100.00", description: "description", redirectUrl: "http://redirectUrl.com",
                                  webhookUrl: "http://webhookUrl.com", method: "ideal"}
        response = Mollie.Payment.post("CUSTOMER_ID", payment)
        assert {:ok, payment} = response
        assert payment.id == "PAYMENT_ID"
      end
    end
  end
end
