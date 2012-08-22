{-# LANGUAGE ForeignFunctionInterface #-}

module Experiment.C2HSBinding.Foreign.HsLTI where

import Foreign.Ptr
import Foreign.C.Types

#include "lib_to_interface.h"

{#pointer LTIData as LTIDataHs #}

{#fun pure unsafe lti_element_count as ^ { id `LTIDataHs' } -> `Int' #}

{#fun pure unsafe lti_get_element as ^ { id `LTIDataHs', `Int' } -> `Int' #}

{#fun pure unsafe lti_new_data as ^ { `Int' } -> `LTIDataHs' id #}