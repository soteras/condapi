defmodule Condapi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Condapi.Repo,
      # Start the Telemetry supervisor
      CondapiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Condapi.PubSub},
      # Start the Endpoint (http/https)
      CondapiWeb.Endpoint
      # Start a worker by calling: Condapi.Worker.start_link(arg)
      # {Condapi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Condapi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CondapiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
