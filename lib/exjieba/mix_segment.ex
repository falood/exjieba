defmodule ExJieba.MixSegment do
  @on_load :load_nif

  def load_nif do
    priv_path = :code.priv_dir(:exjieba)
    path = Path.join(priv_path, "mix_segment")
    :erlang.load_nif(path, 0)
    dict_path = [priv_path, "libcppjieba/dict/jieba.dict.utf8"] |> Path.join() |> to_charlist
    model_path = [priv_path, "libcppjieba/dict/hmm_model.utf8"] |> Path.join() |> to_charlist
    load_dict(dict_path, model_path)
  end

  defp load_dict(_, _) do
    "NIF NOT LOADED"
  end

  def cut(_) do
    "NIF NOT LOADED"
  end
end
