defmodule ExJieba.HMMSegment do
  def init do
    priv_path = :code.priv_dir(:exjieba)
    path = Path.join(priv_path, "hmm_segment")
    :erlang.load_nif(path, 0) |> IO.inspect()
    model_path = [priv_path, "libcppjieba/dict/hmm_model.utf8"] |> Path.join() |> to_charlist
    load_dict(model_path)
  end

  defp load_dict(_) do
    "NIF NOT LOADED"
  end

  def cut(_) do
    "NIF NOT LOADED"
  end
end
