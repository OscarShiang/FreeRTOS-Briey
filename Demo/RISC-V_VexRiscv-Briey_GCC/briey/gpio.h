#ifndef GPIO_H_
#define GPIO_H_

#include "timer.h"
#include "prescaler.h"
#include "interrupt.h"
#include "vga.h"
#include "gpio.h"
#include "uart.h"

typedef struct {
  volatile uint32_t INPUT;
  volatile uint32_t OUTPUT;
  volatile uint32_t OUTPUT_ENABLE;
} Gpio_Reg;

#define CORE_HZ 50000000

#define GPIO_A_BASE    ((Gpio_Reg*)(0xF0000000))
#define GPIO_B_BASE    ((Gpio_Reg*)(0xF0001000))
#define VGA_BASE       ((Vga_Reg*)(0xF0030000))

#define TIMER_PRESCALER ((Prescaler_Reg*)0xF0020000)
#define TIMER_INTERRUPT ((InterruptCtrl_Reg*)0xF0020010)
#define TIMER_A ((Timer_Reg*)0xF0020040)
#define TIMER_B ((Timer_Reg*)0xF0020050)
#define TIMER_C ((Timer_Reg*)0xF0020060)
#define TIMER_D ((Timer_Reg*)0xF0020070)

#define UART      ((Uart_Reg*)(0xF0010000))
#define UART_SAMPLE_PER_BAUD 8

#endif /* GPIO_H_ */
