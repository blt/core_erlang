module Language.Erlang.Lexer where


import Text.Parsec
import Text.Parsec.String (Parser)
import Text.Parsec.Language (emptyDef)

import qualified Text.Parsec.Token as Tok

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

identifier     = Tok.identifier lexer
reserved       = Tok.reserved lexer
operator       = Tok.operator lexer
reservedOp     = Tok.reservedOp lexer
charLiteral    = Tok.charLiteral lexer
stringLiteral  = Tok.stringLiteral lexer
natural        = Tok.natural lexer
integer        = Tok.integer lexer
float          = Tok.float lexer
naturalOrFloat = Tok.naturalOrFloat lexer
decimal        = Tok.decimal lexer
hexadecimal    = Tok.hexadecimal lexer
octal          = Tok.octal lexer
symbol         = Tok.symbol lexer
lexeme         = Tok.lexeme lexer
whiteSpace     = Tok.whiteSpace lexer
parens         = Tok.parens lexer
braces         = Tok.braces lexer
angles         = Tok.angles lexer
brackets       = Tok.brackets lexer
semi           = Tok.semi lexer
comma          = Tok.comma lexer
colon          = Tok.colon lexer
dot            = Tok.dot lexer
semiSep        = Tok.semiSep lexer
semiSep1       = Tok.semiSep1 lexer
commaSep       = Tok.commaSep lexer
commaSep1      = Tok.commaSep1 lexer
