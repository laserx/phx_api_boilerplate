defmodule PhxApiBoilerplateWeb.Router do
  use PhxApiBoilerplateWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxApiBoilerplateWeb do
    pipe_through :api
  end
end
