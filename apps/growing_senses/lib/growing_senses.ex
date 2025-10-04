defmodule GrowingSenses.Logger do
  @moduledoc """
  A GenServer that periodically logs info with a counter.
  """

  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    schedule_log()
    {:ok, %{counter: 0}}
  end

  @impl true
  def handle_info(:log, state) do
    Logger.info("Counter: #{state.counter}")
    schedule_log()
    {:noreply, %{state | counter: state.counter + 1}}
  end

  defp schedule_log do
    # Log every 1 second
    Process.send_after(self(), :log, 1000)
  end
end
