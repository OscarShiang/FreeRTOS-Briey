#ifndef INTERRUPTCTRL_H_
#define INTERRUPTCTRL_H_

#include <stdint.h>

typedef struct
{
  volatile uint32_t PENDINGS;
  volatile uint32_t MASKS;
} InterruptCtrl_Reg;

void interruptCtrl_init(InterruptCtrl_Reg* reg);

#endif /* INTERRUPTCTRL_H_ */
