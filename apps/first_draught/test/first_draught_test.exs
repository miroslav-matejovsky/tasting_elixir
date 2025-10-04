defmodule FirstDraughtTest do
  use ExUnit.Case
  doctest FirstDraught

  test "greets the world" do
    assert FirstDraught.hello() == :world
  end
end
