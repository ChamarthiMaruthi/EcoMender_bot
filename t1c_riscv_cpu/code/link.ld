OUTPUT_ARCH("riscv")
ENTRY(_start)

SECTIONS
{
    . = 0x00000004; /*Start at the address where CPU begins*/
    
    .text : {
        *(.text.start)
        *(.text*)
    }
    
    .rodata : {
        *(.rodata*)
    }
    
    .data : {
        *(.data*)
    }
    
    .bss : {
        *(.bss*)
    }
}
