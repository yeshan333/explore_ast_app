defmodule ExploreAstApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: ExploreAstApp.Worker.start_link(arg)
      # {ExploreAstApp.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: ExploreAstApp.Router, options: [port: cowboy_port()]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExploreAstApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:my_plug_app, :cowboy_port, 8080)
end
