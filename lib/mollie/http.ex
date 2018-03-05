defmodule Mollie.Http do
  alias Mollie.Error
  alias Mollie.Response

  @moduledoc false
  @base_url "https://api.mollie.nl/v1/"

  @spec request(atom, binary, any, any) :: {:ok, Response.t} | {:error, Error.t}
  def request(method, url, body \\ "", api_key \\ nil) do
    url = url |> process_url
    headers = api_key |> get_request_header()
    body = body |> encode_request_body()

    case :hackney.request(method, url, headers, body, []) do
      {:ok, 500, _headers, _client} ->
        {:error, Error.new(500, "Internal Server Error")}
      {:ok, status, headers, client} ->
        case :hackney.body(client) do
          {:ok, body} ->
            {:ok, Response.new(status, headers, body)}
          {:error, reason} ->
            {:error, Error.new(500, reason)}
        end
      {:ok, id} ->
        {:ok, id}
      {:error, reason} ->
        {:error, Error.new(500, reason)}
    end
  end

  def get(url, api_key) do
    request(:get, url, "", api_key)
  end

  def post(url, params, api_key) do
    request(:post, url, params, api_key)
  end

  def delete(url, api_key) do
    request(:delete, url, "", api_key)
  end

  @spec process_url(binary) :: binary
  defp process_url(url) do
    case String.downcase(url) do
      <<"http://"::utf8, _::binary>> -> url
      <<"https://"::utf8, _::binary>> -> url
      _ -> @base_url <> url
    end
  end

  defp encode_request_body(""), do: ""
  defp encode_request_body([]), do: ""
  defp encode_request_body(l) when is_list(l), do: {:form, l}

  defp get_request_header(key) do
    [{:Authorization, "Bearer #{key}"}]
  end
end
