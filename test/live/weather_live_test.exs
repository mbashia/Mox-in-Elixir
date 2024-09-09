defmodule WeatherAppWeb.WeatherLiveTest do
  use WeatherAppWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "search form" do
    test "displays the search form", %{conn: conn} do
      {:ok, view, html} = live(conn, ~p"/weather" )

       
      assert html =~ "Weather App"


   
      assert view
      |> element("#search-button", "Get Weather")
      |> has_element?()

    end
  end
end
