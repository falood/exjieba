defmodule ExJieba do
  use Application.Behaviour

  def start(_, _) do
    {:ok, self}
  end
end
