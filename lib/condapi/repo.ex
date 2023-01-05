defmodule Condapi.Repo do
  use Ecto.Repo,
    otp_app: :condapi,
    adapter: Ecto.Adapters.Postgres
end
