defmodule ElhexDelivery.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    children = [
      supervisor(ElhexDelivery.PostalCode.Supervisor, [])
      #worker(ElhexDelivery.PostalCode.DataStore, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end