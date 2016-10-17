# Mollie for Elixir

**TODO: implement endpoints**
- [ ] Payments API
  - [x] `POST /v1/payments`
  - [x] `GET /v1/payments/*``
  - [x] `GET /v1/payments`
  - [ ] `POST /v1/payments/*/refunds`
  - [ ] `GET /v1/payments/*/refunds/*``
  - [ ] `DELETE /v1/payments/*/refunds/*``
  - [ ] `GET /v1/payments/*/refunds`
- [x] Methods API
  - [x] `GET /v1/methods`
  - [x] `GET /v1/methods/*`
- [x] Issuers API
  - [x] `GET /v1/issuers`
  - [x] `GET /v1/issuers/*`
- [ ] Refunds API
  - [ ] `GET /v1/refunds`
- [ ] Customers API
  - [x] `POST /v1/customers`
  - [x] `GET /v1/customers/*`
  - [ ] `POST /v1/customers/*`
  - [x] `GET /v1/customers`
  - [ ] `POST /v1/customers/*/payments`
  - [ ] `GET /v1/customers/*/payments`
- [ ] Mandates API
  - [ ] `POST /v1/customers/*/mandates`
  - [x] `GET /v1/customers/*/mandates/*`
  - [x] `DELETE /v1/customers/*/mandates/*`
  - [x] `GET /v1/customers/*/mandates`
- [ ] Subscriptions
  - [ ] `POST /v1/customers/*/subscriptions`
  - [ ] `GET /v1/customers/*/subscriptions/*`
  - [ ] `GET /v1/customers/*/subscriptions`
  - [ ] `DELETE /v1/customers/*/subscriptions/*`
- [ ] Connect
  - [ ] `GET /oauth2/authorize`
  - [ ] `GET /oauth2/tokens`
- [ ] Permissions
  - [ ] `GET /v1/permissions/*`
  - [ ] `GET /v1/permissions`
- [ ] Organizations
  - [ ] `GET /v1/organizations/*`
- [ ] Profiles
  - [ ] `POST /v1/profiles`
  - [ ] `GET /v1/profiles/*`
  - [ ] `GET /v1/profiles`
  - [ ] `POST /v1/profiles/*`
  - [ ] `DELETE /v1/profiles/*`
  - [ ] `GET /v1/profiles/*/apikeys`
  - [ ] `GET /v1/profiles/*/apikeys/*`
  - [ ] `POST /v1/profiles/*/apikeys/*`
- [ ] Settlements
  - [ ] `GET /v1/settlements/*`
  - [ ] `GET /v1/settlements/next`
  - [ ] `GET /v1/settlements`
- [ ] Invoices
  - [ ] `GET /v1/invoices/*`
  - [ ] `GET /v1/invoices`

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
