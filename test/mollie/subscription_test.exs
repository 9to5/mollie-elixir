defmodule Mollie.SubscriptionTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/subscription")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing subscription_id" do
    test "it returns a Mollie.Subscription struct" do
      use_cassette "get" do
        customer_id = "CUSTOMER_ID"
        subscription_id = "SUBSCRIPTION_ID"

        response = Mollie.Subscription.get(customer_id, subscription_id)
        assert {:ok, subscription} = response
        assert subscription.id == "SUBSCRIPTION_ID"
      end
    end
  end

  describe "get with a non-existing subscription_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        customer_id = "CUSTOMER_ID"

        response = Mollie.Subscription.get(customer_id, "sub_invalid")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The subscription id is invalid"}}
      end
    end
  end

  describe "post new subscription" do
    test "it returns a Mollie.Subscription struct" do
      use_cassette "post" do
        customer_id = "CUSTOMER_ID"
        subscription = %Mollie.Subscription{amount: "100.00", description: "description", interval: "1 month"}
        response = Mollie.Subscription.post(customer_id, subscription)
        assert {:ok, subscription} = response
        assert subscription.id == "SUBSCRIPTION_ID"
      end
    end

    test "performs an invalid Mollie.Subscription" do
      use_cassette "post_invalid" do
        customer_id = "CUSTOMER_ID"
        subscription = %Mollie.Subscription{}
        response = Mollie.Subscription.post(customer_id, subscription)
        assert {:error, %Mollie.Error{code: 422, reason: "The amount is lower than the minimum"}} = response
      end
    end
  end

  describe "cancel with an existing subscription_id" do
    test "it ok" do
      use_cassette "delete" do
        customer_id = "CUSTOMER_ID"
        subscription_id = "SUBSCRIPTION_ID"

        response = Mollie.Subscription.cancel(customer_id, subscription_id)
        assert {:ok, _subscription} = response
      end
    end
  end
end
