# Mollie for Elixir

**TODO: implement endpoints**
- [x] Payments
- [ ] Payments/:id/Refunds
- [x] Methods
- [ ] Issuers
- [ ] Refunds
- [ ] Customers
- [ ] Customers/:id/Payments
- [ ] Customers/:id/Mandates
- [ ] Subscriptions
- [ ] Connect
- [ ] Permissions
- [ ] Organizations
- [ ] Profiles
- [ ] Profiles/:id/APIkeys
- [ ] Settlements
- [ ] Invoices

Overall features:
- [x] Error responses
- [ ] Pagination

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `mollie` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:mollie, "~> 0.1.0"}]
    end
    ```

  2. Ensure `mollie` is started before your application:

    ```elixir
    def application do
      [applications: [:mollie]]
    end
    ```
