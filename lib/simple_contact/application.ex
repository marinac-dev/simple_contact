defmodule SimpleContact.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      SimpleContact.Repo,
      # Start the Telemetry supervisor
      SimpleContactWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimpleContact.PubSub},
      # Start the Endpoint (http/https)
      SimpleContactWeb.Endpoint
      # Start a worker by calling: SimpleContact.Worker.start_link(arg)
      # {SimpleContact.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleContact.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SimpleContactWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
