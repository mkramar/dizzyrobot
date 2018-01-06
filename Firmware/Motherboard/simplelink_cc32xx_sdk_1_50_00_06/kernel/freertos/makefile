# BOARDNAME below selects the board the kernel is built for. By default,
# '*' is selected as the board name so the kernel is built for all boards.
#
# List of board names supported (choose only one for BOARDNAME):
#
# coresdk_cc13xx_cc26xx_<version>:
# CC1310_LAUNCHXL CC1310DK_7XD CC1350_LAUNCHXL CC1350STK CC2640R2_LAUNCHXL
# CC2650_LAUNCHXL CC2650DK_4XS CC2650DK_5XD CC2650DK_7ID CC2650STK
#
# coresdk_cc32xx_<version>:
# CC3220S_LAUNCHXL CC3220SF_LAUNCHXL
#
# coresdk_msp432_<version>:
# MSP_EXP432P401R MSP_EXP432P4111
#
# coresdk_msp432e4_<version>:
# MSP_EXP432E401Y
#
BOARDNAME ?= *

# Find subdirectories
RELEASE-CCS-SUBDIRS   = $(wildcard builds/$(BOARDNAME)/release/ccs/.)
RELEASE-GCC-SUBDIRS   = $(wildcard builds/$(BOARDNAME)/release/gcc/.)
RELEASE-IAR-SUBDIRS   = $(wildcard builds/$(BOARDNAME)/release/iar/.)

include ../../imports.mak

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

.PHONY: release debug $(RELEASE-SUBDIRS) $(DEBUG-SUBDIRS)

# rules for building
all: release

release: $(RELEASE-SUBDIRS)

$(RELEASE-SUBDIRS):
	@ $(MAKE) -C $@

CLEAN-RELEASE-SUBDIRS = $(addprefix clean-,$(RELEASE-SUBDIRS))

.PHONY: clean-release $(CLEAN-RELEASE-SUBDIRS)

# rules for cleaning
clean: clean-release

clean-release: $(CLEAN-RELEASE-SUBDIRS)

$(CLEAN-RELEASE-SUBDIRS):
	@ $(MAKE) -C $(subst clean-,,$@) clean
