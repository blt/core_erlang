{-# OPTIONS_GHC -XRankNTypes #-}
module Language.Erlang.Parser where

import Data.Functor.Identity (Identity)
import Text.Parsec
import Language.Erlang.AST
import Language.Erlang.Lexer (symbol)

erlCoreParser :: ParsecT String u Identity AST
erlCoreParser = atom

atom :: ParsecT String u Identity AST
atom = quoted_atom <|> bare_atom

quoted_atom :: ParsecT String u Identity AST
quoted_atom = do
  atom_str <- between quote quote $ many (letter <|> digit <|> char '_')
  return $ ErlQuotedAtom atom_str

bare_atom :: ParsecT String u Identity AST
bare_atom = do
  lead_char <- lower
  atom_str <- many $ lower <|> upper <|> digit <|> char '_'
  return $ ErlUnquotedAtom (lead_char:atom_str)

quote :: ParsecT String u Identity String
quote = symbol "'"
