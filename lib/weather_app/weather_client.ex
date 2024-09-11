defmodule WeatherApp.WeatherClient do
  require Logger

  @behaviour WeatherApp.ApiClientBehaviour

  @api_key Application.compile_env(:weather_app, :weather_api_key)
  @base_url "http://api.weatherapi.com/v1/current.json"

  def get_current_weather(location) do
    location_encoded = URI.encode(location)

    url = "#{@base_url}?key=#{@api_key}&q=#{location_encoded}"

    response =
      Finch.build(:get, url)
      |> Finch.request(WeatherApp.Finch)

    case response do
      {:ok, %Finch.Response{status: 200, body: body}} ->
        Logger.info("Success")
        {:ok, process_response(body)}

      {:ok, %Finch.Response{status: status_code}} ->
        Logger.error("Failed with status code #{status_code}")
        {:error, "Failed with status code #{status_code}"}

      {:error, %Finch.Error{reason: reason}} ->
        Logger.error("HTTP request failed: #{reason}")
        {:error, "HTTP request failed: #{reason}"}

      {:error, reason} ->
        Logger.error("big error")
        {:error, reason}
    end
  end

  def process_response(body) do
    body = Jason.decode!(body)

    weather_map =
      %{
        icon: body["current"]["condition"]["icon"],
        temp_c: body["current"]["temp_c"],
        humidity: body["current"]["humidity"],
        wind: body["current"]["wind_kph"],
        precip: body["current"]["precip_mm"]
      }
      |> IO.inspect()

    weather_map
  end
end
