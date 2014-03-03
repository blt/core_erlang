{-# OPTIONS_GHC -XInstanceSigs #-}
module Properties.Core where

import Control.Monad (liftM, replicateM)
import Data.Char (isLower)

import Language.Erlang.AST as AST
import Language.Erlang.Core as Core

import Test.Tasty
import Test.Tasty.QuickCheck as QC

import Test.QuickCheck.Gen

instance Arbitrary AST where
    arbitrary :: Gen AST
    arbitrary = oneof [
                 liftM ErlUnquotedAtom bareAtomGen
                -- , liftM ErlQuotedAtom quoteAtomGen
                , liftM ErlInteger $ choose (-10000, 10000)
                , liftM ErlFloat $ choose (-10000.0, 100000.0)
                , liftM ErlTuple $ tupleGen
                ]

tupleGen = replicateM 3 arbitrary

alphabet :: String
alphabet = '_':['A'..'Z'] ++ ['a'..'z'] ++ ['0'..'9']

bareAtomGen :: Gen String
bareAtomGen = suchThat (listOf1 $ resize 256 $ elements alphabet) (\(s:_) -> isLower s)

quoteAtomGen :: Gen String
quoteAtomGen = liftM (\s -> ('\'':reverse (('\'':reverse s))))
               $ listOf1 $ resize 256 $ elements alphabet

parse_prop :: AST.AST -> Bool
parse_prop ast = (parse s) == (parse . AST.pretty . parse) s
    where
      s = AST.pretty ast
      parse = Core.forceParse

properties :: [TestTree]

properties = [QC.testProperty "parse/pretty-print identity" $ parse_prop ]
