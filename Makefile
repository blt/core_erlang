CABAL=`which cabal`

all: compile

compile:
	@$(CABAL) build

test: compile
	@$(CABAL) install --enable-tests -j
	./dist/build/tests/tests +RTS -N
