defmodule Mollie.IssuerTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("test/fixtures/vcr_cassettes/mollie/issuer")
    ExVCR.Config.filter_sensitive_data("Bearer .+", "TOKEN")
    ExVCR.Config.filter_sensitive_data("(?:\\d{1,3}\\.){3}\\d{1,3}", "0.0.0.0")
    :ok
  end

  describe "get with an existing method_id" do
    test "it returns a Mollie.Issuer struct" do
      use_cassette "get" do
        response = Mollie.Issuer.get("ideal_TESTNL99")
        assert {:ok, method} = response
        assert method.id == "ideal_TESTNL99"
      end
    end
  end

  describe "get with a non-existing method_id" do
    test "it returns an error tuple" do
      use_cassette "missing_get" do
        response = Mollie.Issuer.get("MISSING")
        assert response == {:error, %Mollie.Error{code: 404, reason: "The issuer is invalid"}}
      end
    end
  end
end
