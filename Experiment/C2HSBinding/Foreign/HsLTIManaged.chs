{-# LANGUAGE ForeignFunctionInterface #-}

module Experiment.C2HSBinding.Foreign.HsLTIManaged where

import Foreign.Ptr
import Foreign.ForeignPtr
import Foreign.C.Types
import Foreign.C.String
import Foreign.Marshal.Alloc
import System.IO.Unsafe (unsafePerformIO)

#include "lib_to_interface.h"

foreign import ccall "lib_to_interface.h &lti_free_data"
  ltiFreeDataPtr :: FunPtr (Ptr (LTIDataHs) -> IO ())

foreign import ccall "stdlib.h &free"
  freePtr :: FunPtr (Ptr (String) -> IO ())

newObjectHandle :: Ptr LTIDataHs -> IO LTIDataHs
newObjectHandle p = do
  fp <- newForeignPtr ltiFreeDataPtr p
  return $ LTIDataHs fp

newString :: CString -> IO String
newString p = do
  str <- peekCString p
  free p
  return str

{#pointer LTIData as LTIDataHs foreign newtype #}

{#fun pure unsafe lti_element_count as ^ { withLTIDataHs* `LTIDataHs' } -> `Int' #}

{#fun pure unsafe lti_get_element as ^ { withLTIDataHs* `LTIDataHs', `Int' } -> `Int' #}

{#fun pure unsafe lti_new_data as ^ { `Int' } -> `LTIDataHs' newObjectHandle* #}

{#fun pure unsafe lti_version_information as ^ { `String' } -> `String' newString* #}
