CABAL=`which cabal`

all: configure compile

configure:
	@$(CABAL) configure

compile:
	@$(CABAL) build

test: configure compile
	@$(CABAL) install --enable-tests -j
	./dist/build/tests/tests +RTS -N
