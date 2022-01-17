/*
 * FreeRTOS V202112.00
 * Copyright (C) 2020 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * https://www.FreeRTOS.org
 * https://www.github.com/FreeRTOS
 *
 * 1 tab == 4 spaces!
 */

#include <FreeRTOS.h>

#include <string.h>

#include "riscv-briey.h"
#include "briey/uart.h"

int xGetCoreID( void )
{
int id;

	__asm ("csrr %0, mhartid" : "=r" ( id ) );

	return id;
}

void vSendString( const char *s )
{
	size_t i, len = strlen(s);

	portENTER_CRITICAL();

	for (i = 0; i < len; i++) {
		uart_write(UART, s[i]);
	}
	uart_write(UART, '\n');

	portEXIT_CRITICAL();
}

void handle_trap(void)
{
	vSendString("entering trap");
	while (1)
		;
}

void vPortSetupTimerInterrupt(void)
{
	// asm volatile ("")

        interruptCtrl_init(TIMER_INTERRUPT);
        prescaler_init(TIMER_PRESCALER);
        timer_init(TIMER_A);

        TIMER_PRESCALER->LIMIT = 10;

        TIMER_A->LIMIT = 10;
        TIMER_A->CLEARS_TICKS = 0x00010002;

        TIMER_INTERRUPT->PENDINGS = 0xF;
        TIMER_INTERRUPT->MASKS = 0x1;

        vSendString("interrupt setup");
}
