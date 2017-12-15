defmodule GenstageDemo.Consumer do
  use GenStage

  def start_link(queue_name) do
    GenStage.start_link(__MODULE__, queue_name, name: __MODULE__)
  end

  def init(queue_name) do
    {:consumer, queue_name, subscribe_to: [{GenstageDemo.Producer, max_demand: 10}]}
  end

  def handle_events(events, _from, queue_name) do
    IO.puts "Received events from SQS"
    Enum.each(events, fn(event) ->
      Process.sleep(1000)
      IO.inspect(event)
      ExAws.SQS.delete_message(queue_name, event[:receipt_handle]) |> ExAws.request!
    end)
    IO.puts("finished handling events")
    {:noreply, [], queue_name}
  end

end
