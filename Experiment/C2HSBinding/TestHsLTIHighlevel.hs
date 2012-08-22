module Main where

import System.Environment (getArgs)
import Experiment.C2HSBinding.HsLTIHighlevel

main :: IO ()
main =
    do args <- getArgs
       let counts =
               case args of
                 [] -> [100]
                 _ -> map read args
       if filter (> 1000000) counts /= []
          then putStrLn "That would eat up too much memory"
          else do let ltiCounts = map ltiEnum counts
                  mapM_ print ltiCounts
