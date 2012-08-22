{-# LANGUAGE ForeignFunctionInterface #-}

module Experiment.C2HSBinding.Foreign.HsLTIManaged where

import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.C.Types
import System.IO.Unsafe (unsafePerformIO)

#include "lib_to_interface.h"

foreign import ccall "lib_to_interface.h &lti_free_data"
  ltiFreeDataPtr :: FunPtr (Ptr (LTIDataHs) -> IO ())


newObjectHandle :: Ptr LTIDataHs -> IO LTIDataHs
newObjectHandle p = do
  fp <- newForeignPtr ltiFreeDataPtr p
  return $ LTIDataHs fp

{#pointer LTIData as LTIDataHs foreign newtype #}

{#fun pure unsafe lti_element_count as ^ { withLTIDataHs* `LTIDataHs' } -> `Int' #}

{#fun pure unsafe lti_get_element as ^ { withLTIDataHs* `LTIDataHs', `Int' } -> `Int' #}

{#fun pure unsafe lti_new_data as ^ { `Int' } -> `LTIDataHs' newObjectHandle* #}
