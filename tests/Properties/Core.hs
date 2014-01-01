module Properties.Core where

import qualified Language.Erlang.Core as Core
import Language.Erlang.AST

import Test.Framework (Test)
import Test.HUnit (assertBool, assertEqual, Assertion)
import Test.Framework.Providers.QuickCheck2 (testProperty)
import Test.Framework.Providers.HUnit (testCase)

-- t_concurrent :: String -> Bool
-- t_concurrent s = Core.is_concurrent s

basics :: Assertion
basics = assertEqual "" (Core.p "module 'foo'") (Right (ErlModule {_modName = "foo"}))


--(Core.p "module 'foonane'")

sanity :: Assertion
sanity = assertBool "world is sane" True

properties :: [Test]
properties = [ ] -- testProperty "t_concurrent" $ t_concurrent ]

assertions :: [Test]
assertions = [ testCase "sanity" sanity
             , testCase "basics" basics ]
