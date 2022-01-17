#ifndef TIMERCTRL_H_
#define TIMERCTRL_H_

#include <stdint.h>
#include "briey/gpio.h"

typedef struct {
    volatile uint32_t CLEARS_TICKS;
    volatile uint32_t LIMIT;
    volatile uint32_t VALUE;
} Timer_Reg;

void timer_init(Timer_Reg *reg);

#endif /* TIMERCTRL_H_ */
