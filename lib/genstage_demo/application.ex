defmodule GenstageDemo.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    queue_name = Application.get_env(:genstage_demo, :queue_name)
    children = [
      # Starts a worker by calling: GenstageDemo.Worker.start_link(arg)
      # {GenstageDemo.Worker, arg},
      {GenstageDemo.Producer, queue_name},
      {GenstageDemo.EventEmitter, queue_name},
      # need to send queue name to consumer so we can delete events
      {GenstageDemo.Consumer, queue_name}

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GenstageDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
