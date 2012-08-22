module Experiment.C2HSBinding.HsLTIHighlevel where

import Experiment.C2HSBinding.Foreign.HsLTI

ltiEnum :: Int -> [Int]
ltiEnum n =
    let ltiData = ltiNewData n
        count = ltiElementCount ltiData
        elems = [0..(count-1)]
        ltiElems = map (ltiGetElement ltiData) elems
    in ltiElems
