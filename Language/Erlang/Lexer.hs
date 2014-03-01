module Language.Erlang.Lexer where

import Text.Parsec
import Text.Parsec.Language (emptyDef)

import Data.Functor.Identity (Identity)

import qualified Text.Parsec.Token as Tok

lexer   :: forall u. Tok.GenTokenParser String u Identity
braces  :: forall u a. ParsecT String u Identity a -> ParsecT String u Identity a
comma   :: forall u. ParsecT String u Identity String
float   :: forall u. ParsecT String u Identity Double
integer :: forall u. ParsecT String u Identity Integer
symbol  :: forall u. String -> ParsecT String u Identity String

erlangStyle :: Tok.LanguageDef st
erlangStyle = Tok.LanguageDef
              {
                Tok.commentStart   = ""
              , Tok.commentEnd     = ""
              , Tok.commentLine    = "%"
              , Tok.nestedComments = False
              , Tok.identStart     = letter <|> char '_'
              , Tok.identLetter    = alphaNum <|> oneOf "_'"
              , Tok.opStart        = Tok.opLetter emptyDef
              , Tok.opLetter       = oneOf "+-=/" -- incomplete
              , Tok.reservedOpNames= []
              , Tok.reservedNames  = ["after", "and", "andalso", "band",
                                    "begin", "bnot", "bor", "bsl",
                                    "bsr", "bxor", "case", "catch",
                                    "cond", "div", "end", "fun",
                                    "if", "let", "not", "of", "or",
                                    "orelse", "receive", "rem", "try", "when", "xor"]
              , Tok.caseSensitive  = True
              }


lexer = Tok.makeTokenParser erlangStyle

-- angles         = Tok.angles lexer
braces         = Tok.braces lexer
-- brackets       = Tok.brackets lexer
-- charLiteral    = Tok.charLiteral lexer
-- colon          = Tok.colon lexer
comma          = Tok.comma lexer
-- commaSep       = Tok.commaSep lexer
-- commaSep1      = Tok.commaSep1 lexer
-- decimal        = Tok.decimal lexer
-- dot            = Tok.dot lexer
float          = Tok.float lexer
-- hexadecimal    = Tok.hexadecimal lexer
-- identifier     = Tok.identifier lexer
integer        = Tok.integer lexer
-- lexeme         = Tok.lexeme lexer
-- natural        = Tok.natural lexer
-- naturalOrFloat = Tok.naturalOrFloat lexer
-- octal          = Tok.octal lexer
-- operator       = Tok.operator lexer
-- parens         = Tok.parens lexer
-- reserved       = Tok.reserved lexer
-- reservedOp     = Tok.reservedOp lexer
-- semi           = Tok.semi lexer
-- semiSep        = Tok.semiSep lexer
-- semiSep1       = Tok.semiSep1 lexer
-- stringLiteral  = Tok.stringLiteral lexer
symbol         = Tok.symbol lexer
-- whiteSpace     = Tok.whiteSpace lexer
