# Guard against multiple inclusions
if(__CrayPrgEnv)
  return()
endif()
set(__CrayPrgEnv 1)
if(DEFINED ENV{CRAYPE_VERSION})
  message(STATUS "Cray Programming Environment $ENV{CRAYPE_VERSION}")
elseif(DEFINED ENV{ASYNCPE_VERSION})
  message(STATUS "Cray Programming Environment $ENV{ASYNCPE_VERSION}")
else()
  message(STATUS "Cray Programming Environment")
endif()

if(NOT __CrayLinuxEnvironment)
  message(FATAL_ERROR "The CrayPrgEnv tolchain file must not be used on its own and is intented to be included by the CrayLinuxEnvironment platform file")
endif()

# Flags for the Cray wrappers
foreach(_lang C CXX Fortran)
  set(CMAKE_STATIC_LIBRARY_LINK_${_lang}_FLAGS "-static")
  set(CMAKE_SHARED_LIBRARY_${_lang}_FLAGS "")
  set(CMAKE_SHARED_LIBRARY_CREATE_${_lang}_FLAGS "-shared")
  set(CMAKE_SHARED_LIBRARY_LINK_${_lang}_FLAGS "-dynamic")
endforeach()

# If the link type is not explicitly specified in the environment then
# the Cray wrappers assume that the code will be built staticly
if(NOT ((CMAKE_C_FLAGS MATCHES "(^| )-dynamic($| )") OR
        (CMAKE_EXE_LINKER_FLAGS MATCHES "(^| )-dynamic($| )") OR
        ("$ENV{CRAYPE_LINK_TYPE}" STREQUAL "dynamic")))
  set_property(GLOBAL PROPERTY TARGET_SUPPORTS_SHARED_LIBS FALSE)
  set(BUILD_SHARED_LIBS FALSE CACHE BOOL "")
  set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
  set(CMAKE_LINK_SEARCH_START_STATIC TRUE)
endif()

# Parse the implicit directories used by the wrappers
get_property(_LANGS GLOBAL PROPERTY ENABLED_LANGUAGES)
foreach(_lang IN LISTS _LANGS)
  execute_process(
    COMMAND ${CMAKE_${_lang}_COMPILER} -craype-verbose /dev/null
    OUTPUT_VARIABLE _CRAY_FLAGS
    ERROR_QUIET
  )

  # Parse include paths
  string(REGEX MATCHALL " -I([^ ]+)" _CRAY_INCLUDE_FLAGS "${_CRAY_FLAGS}")
  foreach(_flag IN LISTS _CRAY_INCLUDE_FLAGS)
    string(REGEX REPLACE "^ -I([^ ]+)" "\\1" _dir "${_flag}")
    list(APPEND CMAKE_${_lang}_IMPLICIT_INCLUDE_DIRECTORIES ${_dir})
  endforeach()
  if(CMAKE_${_lang}_IMPLICIT_INCLUDE_DIRECTORIES)
    list(REMOVE_DUPLICATES CMAKE_${_lang}_IMPLICIT_INCLUDE_DIRECTORIES)
  endif()

  # Parse library paths
  string(REGEX MATCHALL " -L([^ ]+)" _CRAY_LIBRARY_DIR_FLAGS "${_CRAY_FLAGS}")
  foreach(_flag IN LISTS _CRAY_LIBRARY_DIR_FLAGS)
    string(REGEX REPLACE "^ -L([^ ]+)" "\\1" _dir "${_flag}")
    list(APPEND CMAKE_${_lang}_IMPLICIT_LINK_DIRECTORIES ${_dir})
  endforeach()
  if(CMAKE_${_lang}_IMPLICIT_LINK_DIRECTORIES)
    list(REMOVE_DUPLICATES CMAKE_${_lang}_IMPLICIT_LINK_DIRECTORIES)
  endif()

  # Parse library paths
  string(REGEX MATCHALL " -l([^ ]+)" _CRAY_LIBRARY_FLAGS "${_CRAY_FLAGS}")
  foreach(_flag IN LISTS _CRAY_LIBRARY_FLAGS)
    string(REGEX REPLACE "^ -l([^ ]+)" "\\1" _dir "${_flag}")
    list(APPEND CMAKE_${_lang}_IMPLICIT_LINK_LIBRARIES ${_dir})
  endforeach()
  if(CMAKE_${_lang}_IMPLICIT_LINK_DIRECTORIES)
    list(REMOVE_DUPLICATES CMAKE_${_lang}_IMPLICIT_LINK_LIBRARIES)
  endif()
endforeach()

# Compute the intersection of several lists
macro(__list_intersection L_OUT L0)
  if(ARGC EQUAL 2)
    list(APPEND ${L_OUT} ${${L0}})
  else()
    foreach(I IN LISTS ${L0})
      set(__is_common 1)
      foreach(L IN LISTS ARGN)
        list(FIND ${L} "${I}" __idx)
        if(__idx EQUAL -1)
          set(__is_common 0)
          break()
        endif()
      endforeach()
      if(__is_common)
        list(APPEND ${L_OUT}  "${I}")
      endif()
    endforeach()
  endif()
  if(${L_OUT})
    list(REMOVE_DUPLICATES ${L_OUT})
  endif()
endmacro()

# Determine the common directories between all languages and add them
# as system search paths
set(_CRAY_INCLUDE_PATH_VARS)
set(_CRAY_LIBRARY_PATH_VARS)
foreach(_lang IN LISTS _LANGS)
  list(APPEND _CRAY_INCLUDE_PATH_VARS CMAKE_${_lang}_IMPLICIT_INCLUDE_DIRECTORIES)
  list(APPEND _CRAY_LIBRARY_PATH_VARS CMAKE_${_lang}_IMPLICIT_LINK_DIRECTORIES)
endforeach()
if(_CRAY_INCLUDE_PATH_VARS)
  __list_intersection(CMAKE_SYSTEM_INCLUDE_PATH ${_CRAY_INCLUDE_PATH_VARS})
endif()
if(_CRAY_LIBRARY_PATH_VARS)
  __list_intersection(CMAKE_SYSTEM_LIBRARY_PATH ${_CRAY_LIBRARY_PATH_VARS})
endif()
