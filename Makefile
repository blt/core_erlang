CABAL=`which cabal`
CABAL_OPTS=--ghc-options=-Werror

all: configure compile

configure:
	@$(CABAL) configure $(CABAL_OPTS)

compile:
	@$(CABAL) build $(CABAL_OPTS)

test: configure compile
	@$(CABAL) install --enable-tests -j
	./dist/build/tests/tests +RTS -N
