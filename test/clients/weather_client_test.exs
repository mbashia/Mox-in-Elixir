defmodule WeatherApp.WeatherClientTests do
  use ExUnit.Case, async: true

  import Mox
  alias WeatherApp.WeatherClient
  setup :verify_on_exit!
  def api_client, do: Application.get_env(:weather_app, :api_client)

  def get_current_weather(location) do
    api_client().get_current_weather(location)
  end

  describe "get weather search" do
    test "passing valid location name to the get current weather function returns the weather details" do
      ApiClientBehaviourMock
      |> expect(:get_current_weather, fn "Nairobi" ->
        {:ok, %{"temperature" => 25, "humidity" => 50}}
      end)

      assert {:ok, %{"temperature" => 25, "humidity" => 50}} =
               get_current_weather("Nairobi")
    end
  end
end
