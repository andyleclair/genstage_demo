defmodule GenstageDemo.ConsumerSupervisor do

  use ConsumerSupervisor

  def start_link(queue_name) do
    ConsumerSupervisor.start_link(__MODULE__, queue_name)
  end

  def init(queue_name) do
    children = [
      worker(GenstageDemo.Printer, [queue_name], restart: :temporary)
    ]

    {:ok, children, strategy: :one_for_one, subscribe_to: [{GenstageDemo.Producer, max_demand: 10}]}
  end
end
