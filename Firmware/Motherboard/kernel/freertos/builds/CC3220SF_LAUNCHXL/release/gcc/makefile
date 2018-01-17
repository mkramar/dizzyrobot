
SIMPLELINK_CC32XX_SDK_INSTALL_DIR ?= $(abspath ../../../../../..)

include $(SIMPLELINK_CC32XX_SDK_INSTALL_DIR)/imports.mak

DRIVERLIB_DIR = $(SIMPLELINK_CC32XX_SDK_INSTALL_DIR)
FREERTOSPORT_DIR = $(SIMPLELINK_CC32XX_SDK_INSTALL_DIR)

VPATH = $(FREERTOS_INSTALL_DIR)/FreeRTOS/Source:$(FREERTOS_INSTALL_DIR)/FreeRTOS/Source/portable/GCC/ARM_CM3:$(FREERTOS_INSTALL_DIR)/FreeRTOS/Source/portable/MemMang:$(FREERTOSPORT_DIR)/kernel/freertos/posix:$(FREERTOSPORT_DIR)/kernel/freertos/dpl:$(FREERTOSPORT_DIR)/kernel/freertos/startup

CC = "$(GCC_ARMCOMPILER)/bin/arm-none-eabi-gcc"
AR = "$(GCC_ARMCOMPILER)/bin/arm-none-eabi-ar"

CFLAGS = -I.. "-I$(FREERTOS_INSTALL_DIR)/FreeRTOS/Source/include" "-I$(FREERTOS_INSTALL_DIR)/FreeRTOS/Source/portable/GCC/ARM_CM3" "-I$(FREERTOSPORT_DIR)/source" "-I$(DRIVERLIB_DIR)/source" "-I$(GCC_ARMCOMPILER)/include" -c -Wunused -Wunknown-pragmas -ffunction-sections -fdata-sections -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -mabi=aapcs

CFILES = \
    croutine.c \
    event_groups.c \
    list.c \
    queue.c \
    tasks.c \
    timers.c \
    port.c \
    heap_4.c \
    clock_freertos.c \
    memory_freertos.c \
    mqueue_freertos.c \
    pthread_barrier_freertos.c \
    pthread_cond_freertos.c \
    pthread_freertos.c \
    pthread_mutex_freertos.c \
    pthread_rwlock_freertos.c \
    sched_freertos.c \
    semaphore_freertos.c \
    sleep_freertos.c \
    timer_freertos.c \
    ClockP_freertos.c \
    DebugP_freertos.c \
    MutexP_freertos.c \
    SemaphoreP_freertos.c \
    SystemP_freertos.c \
    HwiPCC32XX_freertos.c \
    PowerCC32XX_freertos.c \
    startup_cc32xx_gcc.c


OBJCFILES = $(CFILES:.c=.obj)

freertos.lib: $(OBJCFILES)
	@ echo ar $@ ...
	@ $(RM) $@ > $(DEVNULL) 2>&1
	@ $(AR) -cr $@ $(OBJCFILES)

$(CFILES):
	@ echo "Error: can't find $@, please ensure FREERTOS_INSTALL_DIR in $(SIMPLELINK_CC32XX_SDK_INSTALL_DIR)/imports.mak is correct (it is '$(FREERTOS_INSTALL_DIR)')"
	@ exit 1

%.obj:%.c
	@ echo cc $@ ...
	@ $(CC) $(CFLAGS) $< -o $@

clean:
	@ echo cleaning ...
	@ $(RM) *.obj > $(DEVNULL) 2>&1
	@ $(RM) *.lib > $(DEVNULL) 2>&1
