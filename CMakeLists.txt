cmake_minimum_required (VERSION 3.4)
project (optee)

################################################################################
# Flags
################################################################################
set (ARCH "arm32"
	CACHE STRING "OP-TEE TA architecture")

set (PLATFORM "vexpress"
	CACHE STRING "OP-TEE OS platform")

set (PLATFORM_FLAVOR "qemu_virt"
	CACHE STRING "OP-TEE OS platform flavor")

set (OPTEE_TEST_SDK "${CMAKE_SOURCE_DIR}/optee_os/out/arm-plat-${PLATFORM}/export-ta_${ARCH}"
	CACHE STRING "Path to TA-dev-kit")

set (CMAKE_OUT "${CMAKE_SOURCE_DIR}/out"
	CACHE STRING "CMake build folder for OP-TEE")

################################################################################
# Custom commands
################################################################################
add_custom_command (
	OUTPUT optee_test.stamp
	COMMAND make -C ${CMAKE_SOURCE_DIR}/optee_test/ta O=${CMAKE_OUT} TA_DEV_KIT_DIR=${OPTEE_TEST_SDK}
	COMMENT "Compiling xtest Trusted Applications"
	VERBATIM
	)
	
################################################################################
# Custom targets
################################################################################
add_custom_target (
	optee_test-ta ALL
	DEPENDS optee_test.stamp
	)

################################################################################
# Sub projects
################################################################################
add_subdirectory (optee_client)
add_subdirectory (optee_test)
#add_subdirectory (optee_examples)
