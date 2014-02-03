module Main (main) where

import Test.Tasty
import qualified Properties.Core as Core

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = testGroup "Tests" [properties]

properties :: TestTree
properties = testGroup "Properties" qcProps

qcProps :: [TestTree]
qcProps = Core.properties
