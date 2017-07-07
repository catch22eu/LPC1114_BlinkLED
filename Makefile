#MIT License
#
#Copyright (c) 2017 catch22eu
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
##LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.


DEVICE      = cortex-m0
# PORT depends on OS:
# For Linux:
PORT        = /dev/ttyUSB0
BAUD        = 115200
ISPCLK      = 14746
#BAUD       = 9600
FILENAME    = main
GCC         = arm-none-eabi-gcc
LD			= arm-none-eabi-ld
OBJCP		= arm-none-eabi-objcopy
#OPT			= -Wall -Os -std=c99 -nostartfiles -mcpu=$(DEVICE) -mthumb -Wl,-Map,output.map
OPT			= -Wall -Os -std=c99 -specs=nosys.specs -DUSE_OLD_STYLE_DATA_BSS_INIT -mcpu=$(DEVICE) -mthumb -Wl,-Map,output.map
LPCLIBS		= ../LPC11xx-LPCXpresso-CMSIS/CMSISv2p00_LPC11xx/

INC			= $(LPCLIBS)inc/
DEF			= -DCORE_M0 -DENABLE_UNTESTED_CODE
# This is already defined in sys_config:
#-DCHIP_LPC11CXX 

SRC  		 = main.c
SRC			+= $(LPCLIBS)Blinky/cr_startup_lpc11.c
SRC			+= $(LPCLIBS)src/core_cm0.c
SRC			+= $(LPCLIBS)src/system_LPC11xx.c
## add following sources if needed. 
#SRC			+= $(LPCLIBS)adc_1125.c
#SRC			+= $(LPCLIBS)gpio_11xx_2.c
#SRC			+= $(LPCLIBS)pmu_11xx.c
#SRC			+= $(LPCLIBS)timer_11xx.c
#SRC			+= $(LPCLIBS)adc_11xx.c
#SRC			+= $(LPCLIBS)gpiogroup_11xx.c
#SRC			+= $(LPCLIBS)ring_buffer.c
#SRC			+= $(LPCLIBS)uart_11xx.c
#SRC			+= $(LPCLIBS)chip_11xx.c
#SRC			+= $(LPCLIBS)i2c_11xx.c
#SRC			+= $(LPCLIBS)ssp_11xx.c
#SRC			+= $(LPCLIBS)wwdt_11xx.c
#SRC			+= $(LPCLIBS)clock_11xx.c
#SRC			+= $(LPCLIBS)iocon_11xx.c
#SRC			+= $(LPCLIBS)sysctl_11xx.c
#SRC			+= $(LPCLIBS)gpio_11xx_1.c
#SRC			+= $(LPCLIBS)pinint_11xx.c

#copy all $(SRC) files into $(OBJS) and rename them to .o 
OBJS  		= $(SRC:.c=.o)

# Define linker script file here
LINKER_SCRIPT = lpc1114.ld

all: clean $(OBJS) $(FILENAME).elf $(FILENAME).bin upload

%.o: %.c
	$(GCC) -c $(OPT) -I$(INC) $(DEF) $< -o $@
	
%.elf: $(OBJS)
#	$(GCC) $(OPT) $(LIBS) -nostartfiles $(OBJS) -o $@
#	$(GCC) $(OPT) $(LIBS) -nostartfiles -T$(LINKER_SCRIPT) $(OBJS) -o $@
	$(GCC) $(OPT) $(LIBS) -T$(LINKER_SCRIPT) $(OBJS) -o $@

%bin: %elf
	$(OBJCP) -O binary -S $< $@

upload:
	lpc21isp -control -bin $(FILENAME).bin $(PORT) $(BAUD) $(ISPCLK)

clean:
	rm -f $(OBJS)

