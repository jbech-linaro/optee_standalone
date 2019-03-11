export PATH := $(HOME)/toolchains/aarch32/bin:$(PATH)

all: optee-client optee-os optee-test

.PHONY: optee-client
optee-client:
	make -C optee_client INCLUDEDIR=/include LIBDIR=/lib

.PHONY: optee-os
optee-os:
	make -C optee_os CFG_TA_MBEDTLS=n CFG_TA_MBEDTLS_MPI=n

.PHONY: optee-test
optee-test: optee-client optee-os
	make -C optee_test \
		CROSS_COMPILE_HOST=arm-linux-gnueabihf- \
		CROSS_COMPILE_TA=arm-linux-gnueabihf- \
		TA_DEV_KIT_DIR=$(CURDIR)/optee_os/out/arm-plat-vexpress/export-ta_arm32

.PHONY: clean
clean:
	cd $(CURDIR)/optee_client && git clean -xdf && \
		cd $(CURDIR)/optee_os && git clean -xdf && \
		cd $(CURDIR)/optee_test && git clean -xdf
