defmodule HiccupsTest do
  use ExUnit.Case
  doctest Hiccups

  test "greets the world" do
    assert Hiccups.hello() == :world
  end
end
