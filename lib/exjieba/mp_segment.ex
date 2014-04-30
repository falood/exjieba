defmodule ExJieba.MPSegment do
  def init do
    priv_path = :code.priv_dir(:exjieba)
    path = Path.join(priv_path, "mp_segment")
	  :erlang.load_nif(path, 0)
    dict_path = [ priv_path, "libcppjieba/dict/jieba.dict.utf8"
                ] |> Path.join |> to_char_list
    load_dict(dict_path |> to_char_list)
  end

  defp load_dict(_) do
    "NIF NOT LOADED"
  end

  def cut(_) do
    "NIF NOT LOADED"
  end
end