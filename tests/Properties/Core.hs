module Properties.Core where

import Control.Monad (liftM)
import Data.Char (isLower)

import Language.Erlang.AST as AST
import Language.Erlang.Core as Core

import Test.Tasty
import Test.Tasty.QuickCheck as QC

import Test.QuickCheck.Gen

instance Arbitrary AST where
    arbitrary = oneof [
                 liftM ErlUnquotedAtom bareAtomGen
                , liftM ErlQuotedAtom quoteAtomGen
                ]

bareAtomGen :: Gen String
bareAtomGen = suchThat (listOf1 $ resize 256 $ elements alphabet) (\(s:_) -> isLower s)
    where alphabet = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

quoteAtomGen :: Gen String
quoteAtomGen = liftM (\s -> ('\'':reverse (('\'':reverse s))))
               $ listOf1 $ resize 256 $ elements alphabet
    where alphabet = "_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

parse_prop :: AST.AST -> Bool
parse_prop ast = (parse s) == (parse . AST.pretty . parse) s
    where
      s = AST.pretty ast
      parse = Core.forceParse

properties :: [TestTree]
properties = [QC.testProperty "parse/pretty-print identity" $ parse_prop ]
