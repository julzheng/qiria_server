defmodule QiriaServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Client.Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Web.PubSub},
      # Start the Endpoint (http/https)
      Client.Web.Endpoint,
      Client.QiriaGraphQL.Endpoint,
      # Starts a worker by calling: QiriaServer.Worker.start_link(arg)
      # {QiriaServer.Worker, arg}
      Infrastructure.Persistence.Repo
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: QiriaServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Client.Web.Endpoint.config_change(changed, removed)
    Client.QiriaGraphQL.Endpoint.config_change(changed, removed)
    :ok
  end
end
