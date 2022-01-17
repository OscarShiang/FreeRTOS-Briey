#include "briey/gpio.h"
#include "briey/vga.h"

uint32_t vga_isBusy(Vga_Reg *reg)
{
	return (reg->STATUS & 2) != 0;
}

void vga_run(Vga_Reg *reg)
{
	reg->STATUS  = 1;
}

void vga_stop(Vga_Reg *reg)
{
	reg->STATUS  = 0;
	while(vga_isBusy(reg))
	    ;
}
