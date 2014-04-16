ERLANG_PATH:=$(shell erl -eval 'io:format("~s~n", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CPPJIEBA_PATH=priv/libcppjieba/include

CFLAGS=-g -fPIC -O3
ERLANG_FLAGS=-I$(ERLANG_PATH)
CPPJIEBA_FLAGS=-I$(CPPJIEBA_PATH)
CC?=clang
CXX?=clang++
EBIN_DIR=ebin
OPTIONS=-dynamiclib -undefined dynamic_lookup -std=c++11 -DLOGGER_LEVEL=LL_ERROR

NIF_SRC=src/segment.cpp

all:
	mix compile

priv/segment.so: libcppjieba_src
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) $(NIF_SRC) -o $@ 2>&1 >/dev/null

libcppjieba_src:
	git submodule update --init

clean:
	rm -rf priv/segment.*
