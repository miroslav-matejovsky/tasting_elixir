defmodule GrowingSenses do

  @doc "Start the logging process"
  def start_logging, do: GrowingSenses.Logger.start_link([])

  @doc "Stop the logging process"
  def stop_logging, do: GrowingSenses.Logger.stop()

  @doc "Reset the counter"
  def reset_counter, do: GrowingSenses.Logger.reset_counter()

  @doc "Change the log message"
  def change_message(msg), do: GrowingSenses.Logger.change_message(msg)
end

defmodule GrowingSenses.Logger do
  @moduledoc """
  A GenServer that periodically logs info with a counter.
  """

  use GenServer
  require Logger

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  @doc """
  Resets the counter to 0.
  """
  def reset_counter do
    GenServer.call(__MODULE__, :reset)
  end

  @doc """
  Changes the log message prefix.
  """
  def change_message(message) do
    GenServer.call(__MODULE__, {:change_message, message})
  end

  @impl true
  def init(_opts) do
    schedule_log()
    {:ok, %{counter: 0, message: "Counter:"}}
  end

  @impl true
  def handle_call(:reset, _from, state) do
    {:reply, :ok, %{state | counter: 0}}
  end

  @impl true
  def handle_call({:change_message, new_message}, _from, state) do
    {:reply, :ok, %{state | message: new_message}}
  end

  @impl true
  def handle_info(:log, state) do
    Logger.info("#{state.message} #{state.counter}")
    schedule_log()
    {:noreply, %{state | counter: state.counter + 1}}
  end

  defp schedule_log do
    # Log every 1 second
    Process.send_after(self(), :log, 1000)
  end
end
