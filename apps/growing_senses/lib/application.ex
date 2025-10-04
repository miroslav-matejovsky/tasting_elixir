defmodule GrowingSenses.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {GrowingSenses.Logger, []}
    ]

    opts = [strategy: :one_for_one, name: GrowingSenses.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
