/* link.ld - minimal linker script
   Places .text at 0x00000000 and data at 0x02000000 (testbench mapping).
   Provides _stack symbol for startup crt.S.
*/
OUTPUT_ARCH("riscv")

MEMORY
{
  ROM (rx)  : ORIGIN = 0x00000000, LENGTH = 0x00010000  /* 64KB code */
  RAM (rwx) : ORIGIN = 0x02000000, LENGTH = 0x00010000  /* 64KB data */
}

/* stack top symbol */
PROVIDE(_stack = ORIGIN(RAM) + LENGTH(RAM));

SECTIONS
{
  . = ORIGIN(ROM);

  .text : {
    *(.text .text.*)
    *(.rodata .rodata.*)
    PROVIDE (_text = .);
  } > ROM

  .data : AT (ADDR(.text) + SIZEOF(.text)) {
    *(.data .data.*)
    PROVIDE (_data = .);
    PROVIDE (_edata = .);
  } > RAM

  .bss (NOLOAD) : {
    *(.bss .bss.*)
    *(COMMON)
    PROVIDE (_bss = .);
    PROVIDE (_ebss = .);
  } > RAM

  /DISCARD/ : { *(.comment) }
}
