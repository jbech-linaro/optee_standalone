cmake_minimum_required (VERSION 3.4)
project (optee)

set (PLATFORM "vexpress" CACHE STRING "OP-TEE OS platform")
set (PLATFORM_FLAVOR "qemu_virt" CACHE STRING "OP-TEE OS platform flavor")

set (OPTEE_TEST_SDK "${CMAKE_SOURCE_DIR}/optee_os/out/arm-plat-${PLATFORM}/export-ta_arm32" CACHE STRING "Path to TA-dev-kit")

include(GNUInstallDirs)

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
endif(CCACHE_FOUND)

add_custom_command(
	OUTPUT
		optee_test.stamp
	COMMAND
	make -C ${CMAKE_SOURCE_DIR}/optee_test/ta O=${CMAKE_SOURCE_DIR}/out TA_DEV_KIT_DIR=${CMAKE_SOURCE_DIR}/optee_os/out/arm-plat-vexpress/export-ta_arm32/
		#COMMENT
		#"Building optee_os"
	VERBATIM
	)
	

add_custom_command(
	OUTPUT
		optee_os/out
	COMMAND
	make -C ${CMAKE_SOURCE_DIR}/optee_os PLATFORM=${PLATFORM} CFG_TA_MBEDTLS=n CFG_TA_MBEDTLS_MPI=n
		#COMMENT
		#"Building optee_os"
	VERBATIM
	)

add_custom_target(
	optee_os
	DEPENDS optee_os/out
	)

add_custom_target(
	optee_test-ta
	DEPENDS optee_test.stamp
	)

add_subdirectory (optee_client)
add_subdirectory (optee_test)
#add_subdirectory (optee_examples)
#add_subdirectory (optee_os)
