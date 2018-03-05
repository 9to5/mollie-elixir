defmodule Mollie.Base do
  alias Mollie.Error
  alias Mollie.Response
  alias Mollie.Http
  require Logger

  @moduledoc false

  def get(url, struct, config) do
    url
    |> Http.get(config.api_key)
    |> to_response(struct)
  end

  def post(url, params, struct, config) do
    url
    |> Http.post(params, config.api_key)
    |> to_response(struct)
  end

  def delete(url, config) do
    url
    |> Http.delete(config.api_key)
  end

  def default_config() do
    %Mollie.Config{id: :default, api_key: api_key_from_env()}
  end

  defp api_key_from_env() do
    {:ok, key} = Application.fetch_env(:mollie, :api_key)

    case key do
      {:system, env_var} when is_binary(env_var) ->
        case System.get_env(env_var) do
          nil -> "TOKEN"
          api_key -> api_key
        end
      name -> name
    end
  end

  defp to_response({:error, error}, _struct) do
    {:error, Error.new(500, error)}
  end
  defp to_response({:ok, %Response{status_code: 200, body: %{data: data}}}, s) when is_list(s) do
    res = data
    |> Enum.map(&struct(List.first(s), &1))
    {:ok, res}
  end
  defp to_response({:ok, %Response{status_code: 200, body: data}}, s) do
    {:ok, struct(s, data)}
  end
  defp to_response({:ok, %Response{status_code: 201, body: data}}, s) do
    {:ok, struct(s, data)}
  end
  defp to_response({:ok, %Response{status_code: status, body: %{error: %{message: body}}}}, _struct) do
    {:error, Error.new(status, body)}
  end
end
