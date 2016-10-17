defmodule Mollie.Base do
  alias Mollie.Error
  alias Mollie.Response
  alias Mollie.Http
  require Logger

  @moduledoc false

  def get(url, struct) do
    url
    |> Http.get
    |> to_response(struct)
  end

  def post(url, params, struct) do
    url
    |> Http.post(params)
    |> to_response(struct)
  end

  def delete(url) do
    url
    |> Http.delete
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
  defp to_response({:ok, %Response{status_code: 201, body: body}}, s) do
    {:ok, struct(s, body)}
  end
  defp to_response({:ok, %Response{status_code: status, body: %{error: %{message: body}}}}, _struct) do
    {:error, Error.new(status, body)}
  end
end
