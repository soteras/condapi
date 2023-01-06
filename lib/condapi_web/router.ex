defmodule CondapiWeb.Router do
  use CondapiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CondapiWeb do
    pipe_through :api
  end

  scope "/v1", CondapiWeb.Controllers.V1 do
    pipe_through [:api]

    resources "/signin", SigninController, only: [:create]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CondapiWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
