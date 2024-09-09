defmodule WeatherAppWeb.WeatherLive.Index do
  use WeatherAppWeb, :live_view

  alias WeatherApp.WeatherClient
  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, weather: nil, location: "", error: nil)}
  end

  # @impl true
  # def handle_event("get_weather", %{"location" => location}, socket) do

  # end

  @impl true
  def handle_event("get_weather", %{"location" => location}, socket) do
    IO.inspect(location)
    Logger.info("I receive the event")

    case WeatherClient.get_current_weather(location) do
      {:ok, weather} ->
        {:noreply, assign(socket, weather: weather)}

      {:error, reason} ->
        {:noreply, socket |> put_flash(:error, reason)}
    end
  end
end
