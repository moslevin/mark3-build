find_program(CM3_CC arm-none-eabi-gcc)
find_program(CM3_CXX arm-none-eabi-g++)
find_program(CM3_OBJCOPY arm-none-eabi-objcopy)
find_program(CM3_SIZE_TOOL arm-none-eabi-size)
find_program(CM3_OBJDUMP arm-none-eabi-objdump)

#----------------------------------------------------------------------------
set(CM3_CC_FLAGS "\
    -Os \
    -g3 \
    -Wall \
    -c \
    -fdata-sections \
    -ffunction-sections \
    -ffreestanding \
    -fno-exceptions \
    -nostartfiles \
    -mthumb \
    -mcpu=cortex-m3 \
    -DARM \
    -D__CM3_REV=0x0202 \
    -D__MPU_PRESENT=1 \
    -D__FPU_PRESENT=0 \
    -D__NVIC_PRIO_BITS=3 \
    -D__Vendor_SysTickConfig=0 \
    -DUSE_STDPERIPH_DRIVER \
    -D__CHECK_DEVICE_DEFINES \
    -DUSE_FULL_ASSERT \
    -fmessage-length=0
    -mfloat-abi=soft \
    -mthumb-interwork \
    ")

set(CM3_CXX_FLAGS "\
    -Os \
    -g3 \
    -Wall \
    -c \
    -fdata-sections \
    -ffunction-sections \
    -ffreestanding \
    -fno-exceptions \
    -fno-rtti \
    -nostartfiles \
    -mthumb \
    -mcpu=cortex-m3 \
    -std=c++17 \
    -DARM \
    -D__CM3_REV=0x0202 \
    -D__MPU_PRESENT=1 \
    -D__FPU_PRESENT=0 \
    -D__NVIC_PRIO_BITS=3 \
    -D__Vendor_SysTickConfig=0 \
    -DUSE_STDPERIPH_DRIVER \
    -D__CHECK_DEVICE_DEFINES \
    -DUSE_FULL_ASSERT \
    -mfloat-abi=soft \
    -mthumb-interwork \
    -fmessage-length=0
    ")

set(CM3_LN_FLAGS "\
    --specs=nano.specs \
    --disable-newlib-supplied-syscalls \
    -Wl,--start-group \
    -Wl,-lm \
    -Wl,--default-script=${CMAKE_CURRENT_LIST_DIR}/standalone.ld \
    -Wl,--end-group \
    -Wl,--gc-sections \
    -mthumb \
    -mfloat-abi=soft \
    -mthumb-interwork \
    -mcpu=cortex-m3 \
    ")

set(CM3_LN_DBG_FLAGS "\
    --specs=nano.specs \
    --disable-newlib-supplied-syscalls \
    -Wl,--start-group \
    -Wl,--default-script=${CMAKE_CURRENT_LIST_DIR}/standalone.ld \
    -Wl,-lm \
    -Wl,--end-group \
    -mthumb \
    -mfloat-abi=soft \
    -mthumb-interwork \
    -mcpu=cortex-m3 \
    ")

set(CM3_OBJCOPY_FLAGS
    -O ihex -R .eeprom -R .fuse -R .lock -R .signature
    )

set(CM3_OBJCOPY_DBG_FLAGS
    --only-section=.logger -O binary --set-section-flags .logger=alloc --change-section-address .logger=0
    )

set(CM3_BASE_LIBS
    startup semihosting
    )

#----------------------------------------------------------------------------
set_property(GLOBAL PROPERTY global_cc "${CM3_CC}")
set_property(GLOBAL PROPERTY global_cxx "${CM3_CXX}")
set_property(GLOBAL PROPERTY global_objcopy "${CM3_OBJCOPY}")
set_property(GLOBAL PROPERTY global_objdump "${CM3_OBJDUMP}")
set_property(GLOBAL PROPERTY global_size "${CM3_SIZE_TOOL}")
set_property(GLOBAL PROPERTY global_cc_flags "${CM3_CC_FLAGS}")
set_property(GLOBAL PROPERTY global_cxx_flags "${CM3_CXX_FLAGS}")
set_property(GLOBAL PROPERTY global_ln_flags "${CM3_LN_FLAGS}")
set_property(GLOBAL PROPERTY global_ln_dbg_flags "${CM3_LN_DBG_FLAGS}")
set_property(GLOBAL PROPERTY global_objcopy_flags "${CM3_OBJCOPY_FLAGS}")
set_property(GLOBAL PROPERTY global_objcopy_dbg_flags "${CM3_OBJCOPY_DBG_FLAGS}")
set_property(GLOBAL PROPERTY global_base_libs "${CM3_BASE_LIBS}")
