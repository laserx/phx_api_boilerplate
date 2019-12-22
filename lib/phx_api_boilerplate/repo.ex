defmodule PhxApiBoilerplate.Repo do
  use Ecto.Repo,
    otp_app: :phx_api_boilerplate,
    adapter: Ecto.Adapters.Postgres
end
