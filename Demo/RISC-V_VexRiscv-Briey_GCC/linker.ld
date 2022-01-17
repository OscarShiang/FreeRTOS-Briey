OUTPUT_ARCH( "riscv" )
ENTRY( _start )

MEMORY
{
	/* Fake ROM area */
	ram (rxa) : ORIGIN = 0x80000000, LENGTH = 4K
	rom (wxa) : ORIGIN = 0x40000000, LENGTH = 64M
}

SECTIONS
{
	.init :
	{
		KEEP (*(SORT_NONE(.init)))
	} >ram AT>ram
	
	.text :
	{
		_text = .;
		*(.text.unlikely .text.unlikely.*)
		*(.text.startup .text.startup.*)
		*(.text .text.*)
		*(.gnu.linkonce.t.*)
	} >rom AT>rom
	
	.fini :
	{
		KEEP (*(SORT_NONE(.fini)))
		_etext = .;
	} >rom AT>rom

	.rodata.align :
	{
		. = ALIGN(4);
		_rodata = .;
	} >rom AT>rom

	.rodata.start :
	{
		_rodata_lma = LOADADDR(.rodata.start);
	} >rom AT>rom

	.rodata :
	{
		*(.rdata)
		*(.rodata .rodata.*)
		*(.gnu.linkonce.r.*)

		. = ALIGN(4);
		_erodata = .;
	} >rom AT>rom

	.data.align :
	{
		. = ALIGN(4);
		_data = .;
	} >rom AT>rom

	.data.start :
	{
		_data_lma = LOADADDR(.data.start);
	} >rom AT>rom

	.data :
	{
		*(.data .data.*)
		*(.gnu.linkonce.d.*)
		. = ALIGN(8);
		PROVIDE( __global_pointer$ = . + 0x800 );
		*(.sdata .sdata.*)
		*(.sdata2 .sdata2.*)
		*(.gnu.linkonce.s.*)
		. = ALIGN(8);
		*(.srodata.cst16)
		*(.srodata.cst8)
		*(.srodata.cst4)
		*(.srodata.cst2)
		*(.srodata .srodata.*)

		. = ALIGN(4);
		_edata = .;
	} >rom AT>rom

	.bss.align :
	{
		. = ALIGN(4);
		_bss = .;
	} >rom AT>rom

	.bss.start :
	{
		_bss_lma = LOADADDR(.bss.start);
	} >rom AT>rom

	.bss :
	{
		*(.sbss*)
		*(.gnu.linkonce.sb.*)
		*(.bss .bss.*)
		*(.gnu.linkonce.b.*)
		*(COMMON)

		. = ALIGN(4);
		_ebss = .;
	} >rom AT>rom

	. = ALIGN(8);
	_end = .;

	.stack :
	{
		. = ALIGN(16);
		. += __stack_size;
		_stack_top = .;
	} >ram AT>ram
}
