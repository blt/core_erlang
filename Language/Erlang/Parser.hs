{-# OPTIONS_GHC -XRankNTypes #-}
module Language.Erlang.Parser where

import Control.Monad (liftM)
import Data.Functor.Identity (Identity)
import Text.Parsec
import Language.Erlang.AST
import qualified Language.Erlang.Lexer as Lexer

erlCoreParser :: ParsecT String u Identity AST
erlCoreParser = atom
            <|> number
            <|> tuple

tuple :: ParsecT String u Identity AST
tuple = liftM ErlTuple $ Lexer.braces (erlCoreParser `sepBy` (Lexer.comma))

number :: ParsecT String u Identity AST
number = (try float) <|> integer
    where
      integer = liftM ErlInteger $ Lexer.integer
      float = liftM ErlFloat $ Lexer.float

atom :: ParsecT String u Identity AST
atom = quoted_atom <|> bare_atom
    where
      quoted_atom = do
        atom_str <- between quote quote $ many (letter <|> digit <|> char '_')
        return $ ErlQuotedAtom atom_str
      bare_atom = do
        lead_char <- lower
        atom_str <- many $ lower <|> upper <|> digit <|> char '_'
        return $ ErlUnquotedAtom (lead_char:atom_str)

quote :: ParsecT String u Identity String
quote = Lexer.symbol "'"
