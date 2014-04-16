ERLANG_PATH:=$(shell erl -eval 'io:format("~s~n", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CPPJIEBA_PATH=src/nodejieba/src/CppJieba

CFLAGS=-g -fPIC -O3
ERLANG_FLAGS=-I$(ERLANG_PATH)
CPPJIEBA_FLAGS=-I$(CPPJIEBA_PATH)
CC?=clang
CXX?=clang++
EBIN_DIR=ebin
OPTIONS=-dynamiclib -undefined dynamic_lookup -DLOGGER_LEVEL=LL_ERROR

NIF_SRC=src/segment.cpp

all:
	mix compile

priv/segment.so: cppjieba_src
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) $(NIF_SRC) -o $@ 2>&1 >/dev/null

cppjieba_src:
	git submodule update --init

clean:
	rm -rf priv/segment.*
