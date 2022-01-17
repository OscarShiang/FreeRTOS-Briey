#include "briey/timer.h"

void timer_init(Timer_Reg *reg)
{
	reg->CLEARS_TICKS  = 0;
	reg->VALUE = 0;
}
