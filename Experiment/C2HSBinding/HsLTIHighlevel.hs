module Experiment.C2HSBinding.HsLTIHighlevel where

-- {- Unmanaged Version -}
-- import Experiment.C2HSBinding.Foreign.HsLTI

-- -- {- Managed Version -}
-- -- (PLEASE CHANGE c2hs-experiments.cabal accordingly)
import Experiment.C2HSBinding.Foreign.HsLTIManaged

ltiEnum :: Int -> [Int]
ltiEnum n =
    let ltiData = ltiNewData n
        count = ltiElementCount ltiData
        elems = [0..(count-1)]
        ltiElems = map (ltiGetElement ltiData) elems
    in ltiElems
