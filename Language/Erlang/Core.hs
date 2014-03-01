{-# OPTIONS_GHC -fno-warn-orphans #-}

module Language.Erlang.Core (p, forceParse) where

import Language.Erlang.AST
import Language.Erlang.Parser

import Text.Parsec (parse)
import Text.Parsec.Error

p :: String -> Either ParseError AST
p s = parse erlCoreParser "parameter" s

forceParse :: String -> AST
forceParse s = forceEither (parse erlCoreParser "term" s)

forceEither :: Show e => Either e a -> a
forceEither (Left x) = error (show x)
forceEither (Right x) = x
