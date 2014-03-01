{-# OPTIONS_GHC -XDataKinds #-}

module Language.Erlang.AST (AST(..), pretty) where
import Text.PrettyPrint.HughesPJ

data AST
    = ErlQuotedAtom String
    | ErlUnquotedAtom String
    | ErlInteger Integer -- should support Int#Base syntax
    | ErlFloat Double
    | ErlTuple [AST]
    deriving (Show, Eq)

prettyDoc :: AST -> Doc
prettyDoc (ErlUnquotedAtom atom) = text atom
prettyDoc (ErlQuotedAtom atom) = quotes $ text atom
prettyDoc (ErlInteger i) = integer i
prettyDoc (ErlFloat d) = double d
prettyDoc (ErlTuple terms) = braces $ commaSep terms

pretty :: AST -> String
pretty = render . prettyDoc

commaSep :: [AST] -> Doc
commaSep []     = empty
commaSep (t:[]) = prettyDoc t
commaSep (t:ts) = (prettyDoc t) <> comma <> space <> (commaSep ts)
