defmodule Mollie.SubscriptionsTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/subscriptions")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing subscription_id" do
    test "it returns a Mollie.Subscription struct" do
      use_cassette "get" do
        customer_id = "CUSTOMER_ID"
        response = Mollie.Subscriptions.get(customer_id)
        assert {:ok, [subscription1, _subscription2]} = response
        assert subscription1.id == "SUBSCRIPTION_ID"
      end
    end
  end
end
