#include "briey/gpio.h"
#include "briey/uart.h"

uint32_t uart_writeAvailability(Uart_Reg *reg)
{
	return (reg->STATUS >> 16) & 0xFF;
}
uint32_t uart_readOccupancy(Uart_Reg *reg)
{
	return reg->STATUS >> 24;
}

void uart_write(Uart_Reg *reg, uint32_t data)
{
	while(uart_writeAvailability(reg) == 0)
	    /* Wait until ready */;
	reg->DATA = data;
}

void uart_applyConfig(Uart_Reg *reg, Uart_Config *config)
{
	reg->CLOCK_DIVIDER = config->clockDivider;
	reg->FRAME_CONFIG = ((config->dataLength-1) << 0) | (config->parity << 8) | (config->stop << 16);
}
