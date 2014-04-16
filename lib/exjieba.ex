defmodule ExJieba do
  use Application.Behaviour

  def start(_, _) do
    priv_path = :code.priv_dir(:exjieba)
    path = Path.join(priv_path, 'segment')
	  :erlang.load_nif(path, 1)
    load_dict Path.join(priv_path, 'libcppjieba/dict/jieba.dict.utf8'),
              Path.join(priv_path, 'libcppjieba/dict/hmm_model.utf8')
    {:ok, self}
  end

  defp load_dict(_, _) do
    "NIF NOT LOADED"
  end

  def cut(_) do
    "NIF NOT LOADED"
  end
end
