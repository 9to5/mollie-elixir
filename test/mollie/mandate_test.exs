defmodule Mollie.MandateTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/mandate")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing mandate_id" do
    test "it returns a Mollie.Mandate struct" do
      use_cassette "get" do
        customer_id = "CUSTOMER_ID"
        mandate_id = "MANDATE_ID"

        response = Mollie.Mandate.get(customer_id, mandate_id)
        assert {:ok, mandate} = response
        assert mandate.id == "MANDATE_ID"
      end
    end
  end

  describe "get with a non-existing mandate_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        customer_id = "CUSTOMER_ID"

        response = Mollie.Mandate.get(customer_id, "MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The mandate id is invalid"}}
      end
    end
  end

  describe "post new mandate" do
    # Not allowed
    # test "it returns a Mollie.Mandate struct" do
    #   use_cassette "post" do
    #     customer_id = "cst_AfabU898aW"
    #     mandate = %Mollie.Mandate{method: "directdebit", consumerName: "Consumer Name",
    #                               consumerAccount: "NL17RABO0213698412"}
    #     response = Mollie.Mandate.post(customer_id, mandate)
    #     assert {:ok, mandate} = response
    #     assert mandate.id == "MANDATE_ID"
    #   end
    # end

    # test "performs an invalid Mollie.Mandate" do
    #   use_cassette "post_invalid" do
    #     customer_id = "cst_AfabU898aW"
    #     mandate = %Mollie.Mandate{}
    #     response = Mollie.Mandate.post(customer_id, mandate)
    #     assert {:error, %Mollie.Error{code: 422, reason: "The amount is lower than the minimum"}} = response
    #   end
    # end
  end

  describe "revoke with an existing mandate_id" do
    test "it ok" do
      use_cassette "delete" do
        customer_id = "cst_AfabU898aW"
        mandate_id = "mdt_Vhk4nP4Pyw"

        response = Mollie.Mandate.revoke(customer_id, mandate_id)
        assert {:ok, _mandate} = response
      end
    end
  end
end
