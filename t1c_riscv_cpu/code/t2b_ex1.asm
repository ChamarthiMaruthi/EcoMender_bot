
t2b_ex1.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <_start>:
   0:	ff010113          	addi	x2,x2,-16
   4:	00112623          	sw	x1,12(x2)
   8:	00812423          	sw	x8,8(x2)
   c:	01010413          	addi	x8,x2,16
  10:	054000ef          	jal	x1,64 <main>
  14:	0000006f          	jal	x0,14 <_start+0x14>

00000018 <_put_value>:
  18:	fd010113          	addi	x2,x2,-48
  1c:	02812623          	sw	x8,44(x2)
  20:	03010413          	addi	x8,x2,48
  24:	00050793          	addi	x15,x10,0
  28:	fcf40fa3          	sb	x15,-33(x8)
  2c:	fdf44783          	lbu	x15,-33(x8)
  30:	fef407a3          	sb	x15,-17(x8)
  34:	00000013          	addi	x0,x0,0
  38:	02c12403          	lw	x8,44(x2)
  3c:	03010113          	addi	x2,x2,48
  40:	00008067          	jalr	x0,0(x1)

00000044 <_put_str>:
  44:	fe010113          	addi	x2,x2,-32
  48:	00812e23          	sw	x8,28(x2)
  4c:	02010413          	addi	x8,x2,32
  50:	fea42623          	sw	x10,-20(x8)
  54:	00000013          	addi	x0,x0,0
  58:	01c12403          	lw	x8,28(x2)
  5c:	02010113          	addi	x2,x2,32
  60:	00008067          	jalr	x0,0(x1)

00000064 <main>:
  64:	fe010113          	addi	x2,x2,-32
  68:	00112e23          	sw	x1,28(x2)
  6c:	00812c23          	sw	x8,24(x2)
  70:	02010413          	addi	x8,x2,32
  74:	020007b7          	lui	x15,0x2000
  78:	fef42423          	sw	x15,-24(x8)
  7c:	020007b7          	lui	x15,0x2000
  80:	00478793          	addi	x15,x15,4 # 2000004 <main+0x1ffffa0>
  84:	fef42223          	sw	x15,-28(x8)
  88:	020007b7          	lui	x15,0x2000
  8c:	00878793          	addi	x15,x15,8 # 2000008 <main+0x1ffffa4>
  90:	fef42023          	sw	x15,-32(x8)
  94:	fe442783          	lw	x15,-28(x8)
  98:	00078023          	sb	x0,0(x15)
  9c:	00100793          	addi	x15,x0,1
  a0:	fef407a3          	sb	x15,-17(x8)
  a4:	0440006f          	jal	x0,e8 <main+0x84>
  a8:	fe442783          	lw	x15,-28(x8)
  ac:	0007c783          	lbu	x15,0(x15)
  b0:	0ff7f713          	andi	x14,x15,255
  b4:	fef44783          	lbu	x15,-17(x8)
  b8:	00f707b3          	add	x15,x14,x15
  bc:	0ff7f713          	andi	x14,x15,255
  c0:	fe442783          	lw	x15,-28(x8)
  c4:	00e78023          	sb	x14,0(x15)
  c8:	fe442783          	lw	x15,-28(x8)
  cc:	0007c783          	lbu	x15,0(x15)
  d0:	0ff7f793          	andi	x15,x15,255
  d4:	00078513          	addi	x10,x15,0
  d8:	f41ff0ef          	jal	x1,18 <_put_value>
  dc:	fef44783          	lbu	x15,-17(x8)
  e0:	00178793          	addi	x15,x15,1
  e4:	fef407a3          	sb	x15,-17(x8)
  e8:	fe842783          	lw	x15,-24(x8)
  ec:	0007c783          	lbu	x15,0(x15)
  f0:	0ff7f793          	andi	x15,x15,255
  f4:	fef44703          	lbu	x14,-17(x8)
  f8:	fae7f8e3          	bgeu	x15,x14,a8 <main+0x44>
  fc:	fe042783          	lw	x15,-32(x8)
 100:	00100713          	addi	x14,x0,1
 104:	00e78023          	sb	x14,0(x15)
 108:	00000793          	addi	x15,x0,0
 10c:	00078513          	addi	x10,x15,0
 110:	01c12083          	lw	x1,28(x2)
 114:	01812403          	lw	x8,24(x2)
 118:	02010113          	addi	x2,x2,32
 11c:	00008067          	jalr	x0,0(x1)
