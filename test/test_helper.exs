ExUnit.start()
Mox.defmock(ApiClientBehaviourMock, for: WeatherApp.ApiClientBehaviour)

Ecto.Adapters.SQL.Sandbox.mode(WeatherApp.Repo, :manual)
