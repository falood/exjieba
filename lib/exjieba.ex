defmodule ExJieba do
  use Application

  def start(_, _) do
    {:ok, self()}
  end
end
