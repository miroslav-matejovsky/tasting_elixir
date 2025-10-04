defmodule FirstSipTest do
  use ExUnit.Case
  doctest FirstSip

  test "greets the world" do
    assert FirstSip.hello() == :world
  end
end
