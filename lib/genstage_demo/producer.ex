defmodule GenstageDemo.Producer do

  use GenStage

  def start_link(queue_name) do
    GenStage.start_link(__MODULE__, queue_name, name: __MODULE__)
  end

  def init(queue_name) do
    {:producer, queue_name}
  end

  def handle_demand(demand, queue_name) when demand > 0 do
    IO.puts "Handling downstream demand (#{demand}) for messages"
    response = ExAws.SQS.receive_message(queue_name, max_number_of_messages: demand) |> ExAws.request!
    %{body: %{messages: messages}} = response
    {:noreply, messages, queue_name}
  end

  # SQS will return up to 10 messages per request, so don't ask for more than 10
  #def handle_demand(demand, queue_name) when demand > 10 do
  #  IO.puts "Handling downstream demand for messages"
  #  response = ExAws.SQS.receive_message(queue_name, max_number_of_messages: 10) |> ExAws.request!
  #  %{body: %{messages: messages}} = response
  #  {:noreply, messages, queue_name}
  #end
end
