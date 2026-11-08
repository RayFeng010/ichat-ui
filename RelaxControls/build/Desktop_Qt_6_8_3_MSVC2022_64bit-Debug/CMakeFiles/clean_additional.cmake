# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\RelaxControls_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\RelaxControls_autogen.dir\\ParseCache.txt"
  "CMakeFiles\\RelaxControlsplugin_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\RelaxControlsplugin_autogen.dir\\ParseCache.txt"
  "CMakeFiles\\RelaxControlsplugin_init_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\RelaxControlsplugin_init_autogen.dir\\ParseCache.txt"
  "RelaxControls_autogen"
  "RelaxControlsplugin_autogen"
  "RelaxControlsplugin_init_autogen"
  )
endif()
