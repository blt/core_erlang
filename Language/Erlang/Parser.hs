module Language.Erlang.Parser where

import Data.Functor.Identity (Identity)
import Text.Parsec
import Language.Erlang.AST
import Language.Erlang.Lexer (symbol)

erlCoreParser :: forall u. ParsecT String u Identity AST
erlCoreParser = do
  a <- atom
  return $ a
-- do
  -- _ <- symbol "-module"
  -- name <- atom
  -- eof
  -- return $ name
-- ErlModule { _modName = name }
  -- m <- symbol "module"
  -- return (ErlModule { _modName = m })

atom :: forall u. ParsecT String u Identity AST
atom = do
  atom_str <- between quote quote (many1 letter)
  return $ ErlQuotedAtom atom_str

quote :: forall u. ParsecT String u Identity String
quote = symbol "'"
