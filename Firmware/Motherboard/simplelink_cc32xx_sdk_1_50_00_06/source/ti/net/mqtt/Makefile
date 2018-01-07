
# Find subdirectories
RELEASE-CCS-SUBDIRS   = $(wildcard ./ccs/client_FreeRTOS/.)
RELEASE-GCC-SUBDIRS   = $(wildcard ./gcc/client_FreeRTOS/.)
RELEASE-IAR-SUBDIRS   = $(wildcard ./iar/client_FreeRTOS/.)
RELEASE-CCS-SUBDIRS   += $(wildcard ./ccs/client_TIRTOS/.)
RELEASE-GCC-SUBDIRS   += $(wildcard ./gcc/client_TIRTOS/.)
RELEASE-IAR-SUBDIRS   += $(wildcard ./iar/client_TIRTOS/.)
RELEASE-CCS-SUBDIRS   += $(wildcard ./ccs/client_server_FreeRTOS/.)
RELEASE-GCC-SUBDIRS   += $(wildcard ./gcc/client_server_FreeRTOS/.)
RELEASE-IAR-SUBDIRS   += $(wildcard ./iar/client_server_FreeRTOS/.)
RELEASE-CCS-SUBDIRS   += $(wildcard ./ccs/client_server_TIRTOS/.)
RELEASE-GCC-SUBDIRS   += $(wildcard ./gcc/client_server_TIRTOS/.)
RELEASE-IAR-SUBDIRS   += $(wildcard ./iar/client_server_TIRTOS/.)


include ../../../../imports.mak

RELEASE-SUBDIRS =
ifneq ($(CCS_ARMCOMPILER),)
	RELEASE-SUBDIRS += $(RELEASE-CCS-SUBDIRS)
endif
ifneq ($(GCC_ARMCOMPILER),)
	RELEASE-SUBDIRS += $(RELEASE-GCC-SUBDIRS)
endif
ifneq ($(IAR_ARMCOMPILER),)
	RELEASE-SUBDIRS += $(RELEASE-IAR-SUBDIRS)
endif

.PHONY: release $(RELEASE-SUBDIRS)

# rules for building
all: release

release: $(RELEASE-SUBDIRS)

$(RELEASE-SUBDIRS):
	@ $(MAKE) -C $@ -f makefile.defs

CLEAN-RELEASE-SUBDIRS = $(addprefix clean-,$(RELEASE-SUBDIRS))

.PHONY: clean-release $(CLEAN-RELEASE-SUBDIRS)

# rules for cleaning
clean: clean-release

clean-release: $(CLEAN-RELEASE-SUBDIRS)

$(CLEAN-RELEASE-SUBDIRS):
	@ $(MAKE) -C $(subst clean-,,$@) -f makefile.defs clean
