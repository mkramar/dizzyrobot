
SIMPLELINK_CC32XX_SDK_INSTALL_DIR ?= $(abspath ../../..)
include $(SIMPLELINK_CC32XX_SDK_INSTALL_DIR)/imports.mak

# Find all subdirectories
TIRTOS-CCS-SUBDIRS   = $(wildcard */*/tirtos/ccs/.)
TIRTOS-GCC-SUBDIRS   = $(wildcard */*/tirtos/gcc/.)
TIRTOS-IAR-SUBDIRS   = $(wildcard */*/tirtos/iar/.)
FREERTOS-CCS-SUBDIRS = $(wildcard */*/freertos/ccs/.)
FREERTOS-GCC-SUBDIRS = $(wildcard */*/freertos/gcc/.)
FREERTOS-IAR-SUBDIRS = $(wildcard */*/freertos/iar/.)

TIRTOS-SUBDIRS =
FREERTOS-SUBDIRS =
ifneq ($(CCS_ARMCOMPILER),)
	TIRTOS-SUBDIRS += $(TIRTOS-CCS-SUBDIRS)
	FREERTOS-SUBDIRS += $(FREERTOS-CCS-SUBDIRS)
endif
ifneq ($(GCC_ARMCOMPILER),)
	TIRTOS-SUBDIRS += $(TIRTOS-GCC-SUBDIRS)
	FREERTOS-SUBDIRS += $(FREERTOS-GCC-SUBDIRS)
endif
ifneq ($(IAR_ARMCOMPILER),)
	TIRTOS-SUBDIRS += $(TIRTOS-IAR-SUBDIRS)
	FREERTOS-SUBDIRS += $(FREERTOS-IAR-SUBDIRS)
endif

.PHONY: tirtos freertos $(TIRTOS-SUBDIRS) $(FREERTOS-SUBDIRS)

all: tirtos freertos

tirtos: $(TIRTOS-SUBDIRS)

freertos: $(FREERTOS-SUBDIRS)

$(TIRTOS-SUBDIRS):
	@ $(MAKE) -C $@

$(FREERTOS-SUBDIRS):
	@ $(MAKE) -C $@

CLEAN-TIRTOS-SUBDIRS = $(addprefix clean-,$(TIRTOS-SUBDIRS))
CLEAN-FREERTOS-SUBDIRS = $(addprefix clean-,$(FREERTOS-SUBDIRS))

.PHONY: clean-tirtos clean-freertos $(CLEAN-TIRTOS-SUBDIRS) $(CLEAN-FREERTOS-SUBDIRS)

clean: clean-tirtos clean-freertos

clean-tirtos: $(CLEAN-TIRTOS-SUBDIRS)
clean-freertos: $(CLEAN-FREERTOS-SUBDIRS)

$(CLEAN-TIRTOS-SUBDIRS):
	@ $(MAKE) -C $(subst clean-,,$@) clean

$(CLEAN-FREERTOS-SUBDIRS):
	@ $(MAKE) -C $(subst clean-,,$@) clean
