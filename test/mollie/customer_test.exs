defmodule Mollie.CustomerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/customer")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing customer_id" do
    test "it returns a Mollie.Customer struct" do
      use_cassette "get" do
        customer_id = "CUSTOMER_ID"
        response = Mollie.Customer.get(customer_id)
        assert {:ok, customer} = response
        assert customer.id == "CUSTOMER_ID"
      end
    end
  end

  describe "get with a non-existing customer_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        response = Mollie.Customer.get("MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The customer id is invalid"}}
      end
    end
  end

  describe "post new customer" do
    test "it returns a Mollie.Customer struct" do
      use_cassette "post" do
        customer = %Mollie.Customer{name: "Test Name", email: "email@example.com"}
        response = Mollie.Customer.post(customer)
        assert {:ok, customer} = response
        assert customer.id == "CUSTOMER_ID"
      end
    end
  end

  describe "update customer" do
    test "it udpates a Mollie.Customer" do
      use_cassette "post_update" do
        customer = %Mollie.Customer{name: "Test Name2", email: "email@example.com"}
        response = Mollie.Customer.update("CUSTOMER_ID", customer)
        assert {:ok, customer} = response
        assert customer.id == "CUSTOMER_ID"
        assert customer.name == "Test Name2"
      end
    end
  end
end
