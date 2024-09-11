defmodule WeatherApp.ApiClientBehaviour do
  @callback get_current_weather(String.t()) :: {:ok, map()} | {:error, String.t()}
end
