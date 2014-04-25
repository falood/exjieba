defmodule Mix.Tasks.Compile.Segment do
  def run(_) do
    Mix.shell.info System.cmd("make priv/segment.so")
  end
end

defmodule Exjieba.Mixfile do
  use Mix.Project

  def project do
    [ app: :exjieba,
      version: "0.0.1",
      elixir: "~> 0.13.0",
      compilers: [ :segment, :elixir, :app ],
      deps: deps 
    ]
  end

  def application do
    [mod: { ExJieba, [] }]
  end

  defp deps do
    []
  end
end
