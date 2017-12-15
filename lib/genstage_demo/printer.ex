defmodule GenstageDemo.Printer do

  def start_link(message) do
    Task.start_link(fn ->
      IO.inspect message
    end)
  end
end
