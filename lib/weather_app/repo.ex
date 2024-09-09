defmodule WeatherApp.Repo do
  use Ecto.Repo,
    otp_app: :weather_app,
    adapter: Ecto.Adapters.MyXQL
end
