module Language.Erlang.Parser where

import Data.Functor.Identity (Identity)
import Text.Parsec
import Language.Erlang.AST
import Language.Erlang.Lexer

erlCoreParser :: forall u. ParsecT String u Identity AST
erlCoreParser = do
  _ <- symbol "module"
  name <- atom
  -- name <- between (symbol "'") (symbol "'") symbol
  eof
  return $ ErlModule { _modName = name }
  -- m <- symbol "module"
  -- return (ErlModule { _modName = m })

atom :: forall u. ParsecT String u Identity String
atom = between (symbol "'") (symbol "'") (many1 letter)
