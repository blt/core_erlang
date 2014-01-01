module Main (main) where

import Test.Framework (defaultMain, testGroup, Test)

import qualified Properties.Core as Core

properties :: [Test]
properties = [ testGroup "core" Core.properties ]

assertions :: [Test]
assertions = [ testGroup "core_assertions" Core.assertions ]

main :: IO()
main = defaultMain [
        testGroup "properties" properties,
        testGroup "assertions" assertions
       ]
