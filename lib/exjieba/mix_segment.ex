defmodule ExJieba.MixSegment do
  def init do
    priv_path = :code.priv_dir(:exjieba)
    path = Path.join(priv_path, "mix_segment")
	  :erlang.load_nif(path, 0)
    dict_path = [ priv_path, "libcppjieba/dict/jieba.dict.utf8"
                ] |> Path.join |> to_char_list
    model_path = [ priv_path, "libcppjieba/dict/hmm_model.utf8"
                 ] |> Path.join |> to_char_list
    load_dict(dict_path, model_path)
  end

  defp load_dict(_, _) do
    "NIF NOT LOADED"
  end

  def cut(_) do
    "NIF NOT LOADED"
  end
end