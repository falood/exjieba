#include "erl_nif.h"
#include "MixSegment.hpp"

CppJieba::MixSegment segment;

extern "C"{
static ERL_NIF_TERM cut(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    ErlNifBinary bin;
    enif_inspect_binary(env, argv[0], &bin);
    char *s = new char[bin.size + 1];
    memcpy(s, bin.data, bin.size);
    s[bin.size] = '\0';

    std::vector<std::string> words;
    segment.cut(s, words);

    ERL_NIF_TERM r = enif_make_list(env, 0);
    ErlNifBinary h;
    size_t len;

    for(std::vector<std::string>::iterator i = words.begin(); i != words.end(); ++i) {
        len = strlen(i->c_str());
        enif_alloc_binary(len, &h);
        memcpy(h.data, i->c_str(), len);
        r = enif_make_list_cell(env, enif_make_binary(env, &h), r);
    }

    ERL_NIF_TERM result;
    enif_make_reverse_list(env, r, &result);
    return result;
}

static ERL_NIF_TERM load_dict(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    unsigned int len;
    enif_get_list_length(env, argv[0], &len);
    char *words_dict = (char *)enif_alloc(++len);
    enif_get_string(env, argv[0], words_dict, len, ERL_NIF_LATIN1);

    enif_get_list_length(env, argv[1], &len);
    char *model_dict = (char *)enif_alloc(++len);
    enif_get_string(env, argv[1], model_dict, len, ERL_NIF_LATIN1);

    segment.init(words_dict, model_dict);
    return enif_make_atom(env, "ok\0");
}

static ErlNifFunc nif_funcs[] =
{
    {"cut", 1, cut},
    {"load_dict", 2, load_dict}
};
}
ERL_NIF_INIT(Elixir.ExJieba.MixSegment, nif_funcs, NULL, NULL, NULL, NULL)
