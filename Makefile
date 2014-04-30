ERLANG_PATH:=$(shell erl -eval 'io:format("~s~n", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version), "/include"])])' -s init stop -noshell)
CPPJIEBA_PATH=priv/libcppjieba/include

CFLAGS=-g -fPIC -O3
ERLANG_FLAGS=-I$(ERLANG_PATH)
CPPJIEBA_FLAGS=-I$(CPPJIEBA_PATH)
CC?=clang
CXX?=clang++
EBIN_DIR=ebin

ifeq ($(shell uname),Darwin)
	OPTIONS=-dynamiclib -undefined dynamic_lookup -std=c++11
else
	OPTIONS=-lstdc++
endif

all:
	mix compile

libcppjieba_src:
	git submodule update --init

segment: clean libcppjieba_src priv/mp_segment.so priv/hmm_segment.so priv/mix_segment.so priv/query_segment.so

priv/mp_segment.so:
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) -DLOGGER_LEVEL=LL_ERROR src/mp_segment.cpp -o $@ 2>&1 >/dev/null

priv/mix_segment.so:
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) -DLOGGER_LEVEL=LL_ERROR src/mix_segment.cpp -o $@ 2>&1 >/dev/null

priv/hmm_segment.so:
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) -DLOGGER_LEVEL=LL_ERROR src/hmm_segment.cpp -o $@ 2>&1 >/dev/null

priv/query_segment.so:
	mkdir -p priv && \
	$(CC) $(CFLAGS) $(ERLANG_FLAGS) $(CPPJIEBA_FLAGS) -shared $(OPTIONS) -DLOGGER_LEVEL=LL_ERROR src/query_segment.cpp -o $@ 2>&1 >/dev/null


clean:
	rm -rf priv/*_segment.*
