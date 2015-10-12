add_executable(test test.cxx)

if (NOT DEFINED_AFTER_SUBDIRS_COMMAND)
  message(FATAL_ERROR "DEFINED_AFTER_SUBDIRS_COMMAND should be defined.")
endif()
