defmodule GenstageTestTest do
  use ExUnit.Case
  doctest GenstageTest

  test "greets the world" do
    assert GenstageTest.hello() == :world
  end
end
