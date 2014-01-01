{-# OPTIONS_GHC -fno-warn-orphans #-}

module Language.Erlang.Core
    (
      p
    ) where

-- import Data.Text (pack, Text)

import Language.Erlang.AST
import Language.Erlang.Parser (erlCoreParser)

import Text.Parsec (parse, ParseError) -- char, chainl1, eof, many1, digit, parse, ParseError)
import Text.Parsec.Error
-- import Text.Parsec.Text

instance Eq ParseError where
   a == b = errorMessages a == errorMessages b

p :: String -> Either ParseError AST
p s = parse erlCoreParser "parameter" s

-- -- from Text.Parsec.Text: type Parser a = ParsecT Text () Identity a
-- pmain :: Parser Integer
-- pmain = do
--   x <- pnum `chainl1` pplus
--   eof
--   return x

-- pnum = read `fmap` many1 digit

-- pplus = char '+' >> return (+)
