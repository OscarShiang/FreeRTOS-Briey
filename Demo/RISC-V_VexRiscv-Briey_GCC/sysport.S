#include "freertos_risc_v_chip_specific_extensions.h"

#if __riscv_xlen == 64
#define STORE    sd
#define LOAD     ld
#define REGBYTES 8
#else
#define STORE    sw
#define LOAD     lw
#define REGBYTES 4
#endif

/* Enable interrupts when returning from the handler */
#define MSTATUS_PRV1 0x1880

.global portSAVE_CONTEXT
.global portRESTORE_CONTEXT
.global vPortYield
.global	pxCurrentTCB

/* Macro for saving task context */
.macro portSAVE_CONTEXT
	/* make room in stack */
	addi	sp, sp, -REGBYTES * 31

	/* Save Context */
	STORE	x1, 1 * REGBYTES(sp)
	STORE	x5, 2 * REGBYTES(sp)
	STORE	x6, 3 * REGBYTES(sp)
	STORE	x7, 4 * REGBYTES(sp)
	STORE	x8, 5 * REGBYTES(sp)
	STORE	x9, 6 * REGBYTES(sp)
	STORE	x10, 7 * REGBYTES(sp)
	STORE	x11, 8 * REGBYTES(sp)
	STORE	x12, 9 * REGBYTES(sp)
	STORE	x13, 10 * REGBYTES(sp)
	STORE	x14, 11 * REGBYTES(sp)
	STORE	x15, 12 * REGBYTES(sp)
	STORE	x16, 13 * REGBYTES(sp)
	STORE	x17, 14 * REGBYTES(sp)
	STORE	x18, 15 * REGBYTES(sp)
	STORE	x19, 16 * REGBYTES(sp)
	STORE	x20, 17 * REGBYTES(sp)
	STORE	x21, 18 * REGBYTES(sp)
	STORE	x22, 19 * REGBYTES(sp)
	STORE	x23, 20 * REGBYTES(sp)
	STORE	x24, 21 * REGBYTES(sp)
	STORE	x25, 22 * REGBYTES(sp)
	STORE	x26, 23 * REGBYTES(sp)
	STORE	x27, 24 * REGBYTES(sp)
	STORE	x28, 25 * REGBYTES(sp)
	STORE	x29, 26 * REGBYTES(sp)
	STORE	x30, 27 * REGBYTES(sp)
	STORE	x31, 28 * REGBYTES(sp)

	csrr t0, mstatus
	STORE	t0, 29 * REGBYTES(sp)

	portasmRESTORE_ADDITIONAL_REGISTERS
	
	LOAD	t0, pxCurrentTCB
	STORE	sp, 0(t0)

	STORE	x1, 0(sp)
	STORE	x2, 1 * REGBYTES(sp)
	STORE	x3, 2 * REGBYTES(sp)
	STORE	x4, 3 * REGBYTES(sp)
	STORE	x5, 4 * REGBYTES(sp)
	STORE	x6, 5 * REGBYTES(sp)
	STORE	x7, 6 * REGBYTES(sp)
	STORE	x8, 7 * REGBYTES(sp)
	STORE	x9, 8 * REGBYTES(sp)
	STORE	x10, 9 * REGBYTES(sp)
	STORE	x11, 10 * REGBYTES(sp)
	STORE	x12, 11 * REGBYTES(sp)
	STORE	x13, 12 * REGBYTES(sp)
	STORE	x14, 13 * REGBYTES(sp)
	STORE	x15, 14 * REGBYTES(sp)
	STORE	x16, 15 * REGBYTES(sp)
	STORE	x17, 16 * REGBYTES(sp)
	STORE	x18, 17 * REGBYTES(sp)
	STORE	x19, 18 * REGBYTES(sp)
	STORE	x20, 19 * REGBYTES(sp)
	STORE	x21, 20 * REGBYTES(sp)
	STORE	x22, 21 * REGBYTES(sp)
	STORE	x23, 22 * REGBYTES(sp)
	STORE	x24, 23 * REGBYTES(sp)
	STORE	x25, 24 * REGBYTES(sp)
	STORE	x26, 25 * REGBYTES(sp)
	STORE	x27, 26 * REGBYTES(sp)
	STORE	x28, 27 * REGBYTES(sp)
	STORE	x29, 28 * REGBYTES(sp)
	STORE	x30, 29 * REGBYTES(sp)
	STORE	x31, 30 * REGBYTES(sp)
	
	/* Store current stackpointer in task control block (TCB) */
	LOAD	t0, pxCurrentTCB	//pointer
	STORE	sp, 0x0(t0)
.endm

/* Saves current error program counter (EPC) as task program counter */
.macro portSAVE_EPC
  	csrr	t0, mepc
	STORE	t0, 31 * REGBYTES(sp)
.endm

/* Saves current return adress (RA) as task program counter */
.macro portSAVE_RA
	STORE	ra, 31 * REGBYTES(sp)
.endm

.macro portRESTORE_CONTEXT
	/* Load stack pointer from the current TCB */
	LOAD	sp, pxCurrentTCB
	LOAD	sp, 0(sp)

	LOAD	x1, 0(sp)
	portasmRESTORE_ADDITIONAL_REGISTERS

	/* Restore registers,
	   Skip global pointer because that does not change */
	LOAD	x6, 5 * REGBYTES(sp)
	LOAD	x7, 6 * REGBYTES(sp)
	LOAD	x8, 7 * REGBYTES(sp)
	LOAD	x9, 8 * REGBYTES(sp)
	LOAD	x10, 9 * REGBYTES(sp)
	LOAD	x11, 10 * REGBYTES(sp)
	LOAD	x12, 11 * REGBYTES(sp)
	LOAD	x13, 12 * REGBYTES(sp)
	LOAD	x14, 13 * REGBYTES(sp)
	LOAD	x15, 14 * REGBYTES(sp)
	LOAD	x16, 15 * REGBYTES(sp)
	LOAD	x17, 16 * REGBYTES(sp)
	LOAD	x18, 17 * REGBYTES(sp)
	LOAD	x19, 18 * REGBYTES(sp)
	LOAD	x20, 19 * REGBYTES(sp)
	LOAD	x21, 20 * REGBYTES(sp)
	LOAD	x22, 21 * REGBYTES(sp)
	LOAD	x23, 22 * REGBYTES(sp)
	LOAD	x24, 23 * REGBYTES(sp)
	LOAD	x25, 24 * REGBYTES(sp)
	LOAD	x26, 25 * REGBYTES(sp)
	LOAD	x27, 26 * REGBYTES(sp)
	LOAD	x28, 27 * REGBYTES(sp)
	LOAD	x29, 28 * REGBYTES(sp)
	LOAD	x30, 29 * REGBYTES(sp)
	LOAD	x31, 30 * REGBYTES(sp)

	LOAD	x5, 29 * REGBYTES(sp)
	addi x5, x5, 0x08
	csrrw x0, mstatus, x5

	LOAD x5, 2 * REGBYTES(sp)
	
	addi sp, sp, REGBYTES * 31
	ret
.endm

vPortYield:
	/*
	*  This routine can be called from outside of interrupt handler. This means
	*  interrupts may be enabled at this point. This is probably okay for registers and
	*  stack. However, "mepc" will be overwritten by the interrupt handler if a timer
	*  interrupt happens during the yield. To avoid this, prevent interrupts before starting.
	*  The write to mstatus in the restore context routine will enable interrupts after the
	*  mret. A more fine-grain lock may be possible.
	*/
	csrci mstatus, 8

	portSAVE_CONTEXT
	portSAVE_RA
	jal	vTaskSwitchContext
	portRESTORE_CONTEXT
