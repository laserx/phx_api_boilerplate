defmodule PhxApiBoilerplateWeb.Router do
  use PhxApiBoilerplateWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PhxApiBoilerplateWeb do
    pipe_through :api
  end

  # Route for Log Viewer
  forward("/log_viewer", LogViewer.Router)
end
