module Language.Erlang.AST (AST(..)) where

data AST
    = ErlModule { _modName :: String }
    deriving (Show, Eq)
