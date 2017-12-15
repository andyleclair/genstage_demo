defmodule GenstageDemo.EventEmitter do

  use GenServer

  def start_link(queue_name) do
    GenServer.start_link(__MODULE__, queue_name)
  end

  def init(queue_name) do
    emit_event()
    {:ok, queue_name}
  end

  def handle_info(:emit_event, queue_name) do
    emit_event()
    ExAws.SQS.send_message(queue_name, "#{:erlang.system_time(:milli_seconds)}") |> ExAws.request!
    {:noreply, queue_name}
  end

  def emit_event() do
    Process.send_after(self(), :emit_event, 1000)
  end
end
