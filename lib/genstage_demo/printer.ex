defmodule GenstageDemo.Printer do
  use Task

  def start_link(queue_name, message) do
    Task.start_link(fn ->
      Process.sleep(1000)
      IO.inspect {self(), message}
      ExAws.SQS.delete_message(queue_name, message[:receipt_handle]) |> ExAws.request!
    end)
  end
end
