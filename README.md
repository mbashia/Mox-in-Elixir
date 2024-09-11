Mox in Elixir: Testing with Mocks
This repository demonstrates how to use Mox in Elixir for testing modules that make external API calls. It showcases how to mock external dependencies, allowing for isolated and reliable tests.

Overview
The project aims to showcase how Mox can be used to mock an external weather API, using a weather client module. By mocking the HTTP client, we can test our logic without making real HTTP requests. This is helpful when testing code that relies on external services to avoid network delays or changes in external service data.

Key Concepts Covered
Mox: A library to define mocks based on behaviours, making it possible to replace dependencies in tests.
Finch: A modern, extensible HTTP client for Elixir.
ExUnit: The built-in test framework in Elixir.


Installation
To get started with this project, follow these steps:

Clone the repository:

git clone https://github.com/mbashia/Mox-in-Elixir.git
cd Mox-in-Elixir
Install dependencies:


mix deps.get
Run the tests to ensure everything is working:


mix test
Setting up Environment Variables
To configure your API key, set it up in your environment variables. This can be done by creating a .env file or exporting the variables directly in your shell.

Example:

export WEATHER_API_KEY="your_api_key"
Behaviour and Mox Setup
In this project, we define a behaviour for the WeatherClient to follow:


defmodule WeatherApp.ApiClientBehaviour do
  @callback get_current_weather(String.t()) :: {:ok, map()} | {:error, String.t()}
end
We then create a mock for this behaviour using Mox in our test suite:


Mox.defmock(ApiClientBehaviourMock, for: WeatherApp.ApiClientBehaviour)
This allows us to define mock expectations in our tests, ensuring our WeatherClient behaves correctly.

Example Test
Here is an example of how we mock the weather API response in our test:


defmodule WeatherApp.WeatherClientTests do
  use ExUnit.Case, async: true

  import Mox
  alias WeatherApp.WeatherClient

  setup :verify_on_exit!

  describe "get weather search" do
    test "passing valid location name to the get_current_weather function returns the weather details" do
      ApiClientBehaviourMock
      |> expect(:get_current_weather, fn "Nairobi" ->
        {:ok, %{"temperature" => 25, "humidity" => 50}}
      end)

      assert {:ok, %{"temperature" => 25, "humidity" => 50}} =
               WeatherClient.get_current_weather("Nairobi")
    end
  end
end
Running the Tests
You can run the test suite with:

mix test
Mox will ensure that all expectations set during a test are verified, and the mock is only used in the scope of the test.
WeatherApp
To start your Phoenix server:

Run mix setup to install and setup dependencies
Start Phoenix endpoint with mix phx.server or inside IEx with iex -S mix phx.server
Now you can visit localhost:4000 from your browser.

Ready to run in production? Please check our deployment guides.

Learn More
Official website: https://www.phoenixframework.org/
Guides: https://hexdocs.pm/phoenix/overview.html
Docs: https://hexdocs.pm/phoenix
Forum: https://elixirforum.com/c/phoenix-forum
Source: https://github.com/phoenixframework/phoenix
Conclusion
This project provides a simple and clear way to integrate Mox into your Elixir projects for testing. By mocking external API calls, you can make your tests more efficient and reliable, while adhering to Elixir’s functional principles.

