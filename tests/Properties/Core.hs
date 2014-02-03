module Properties.Core where

import Control.Monad (liftM)
import Data.Char (isLower)

import Language.Erlang.AST as AST
import Language.Erlang.Core as Core

import Test.Framework (Test)
import Test.Framework.Providers.QuickCheck2
import Test.QuickCheck.Arbitrary
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

-- basics :: Assertion
-- basics = assertEqual "" (Core.p "module 'foo'") (Right (ErlModule {_modName = "foo"}))

-- atom :: Assertion
-- atom =  assertEqual "" (Prs.atom "'anatom'") (Prs.atom "anatom")

-- quoted_atom :: Assertion
-- quoted_atom = assertEqual "" (parse Prs.atom "'anatom'") (Right (ErlAtom "anatom"))

-- underscore_atom :: Assertion
-- underscore_atom = assertEqual "" (Prs.atom "an_atom") (Right (ErlAtom "an_atom"))

properties :: [Test]
properties = [ testProperty "parse_prop" $ parse_prop ]

assertions :: [Test]
assertions = [ ]
