{-# OPTIONS_GHC -XDataKinds #-}

module Language.Erlang.AST (AST(..), pretty) where
import Text.PrettyPrint.HughesPJ

data AST
    = ErlQuotedAtom String
    | ErlUnquotedAtom String
    -- | ErlModule { _modName :: ErlAtom }
    deriving (Show, Eq)

prettyDoc :: AST -> Doc
prettyDoc (ErlUnquotedAtom atom) = text atom
prettyDoc (ErlQuotedAtom atom) = quotes $ text atom

pretty :: AST -> String
pretty = render . prettyDoc
