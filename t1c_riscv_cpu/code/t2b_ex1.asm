
t2b_ex1.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000004 <_start>:
   4:	ff010113          	addi	x2,x2,-16
   8:	00112623          	sw	x1,12(x2)
   c:	00812423          	sw	x8,8(x2)
  10:	01010413          	addi	x8,x2,16
  14:	054000ef          	jal	x1,68 <main>
  18:	0000006f          	jal	x0,18 <_start+0x14>

0000001c <_put_value>:
  1c:	fd010113          	addi	x2,x2,-48
  20:	02812623          	sw	x8,44(x2)
  24:	03010413          	addi	x8,x2,48
  28:	00050793          	addi	x15,x10,0
  2c:	fcf40fa3          	sb	x15,-33(x8)
  30:	fdf44783          	lbu	x15,-33(x8)
  34:	fef407a3          	sb	x15,-17(x8)
  38:	00000013          	addi	x0,x0,0
  3c:	02c12403          	lw	x8,44(x2)
  40:	03010113          	addi	x2,x2,48
  44:	00008067          	jalr	x0,0(x1)

00000048 <_put_str>:
  48:	fe010113          	addi	x2,x2,-32
  4c:	00812e23          	sw	x8,28(x2)
  50:	02010413          	addi	x8,x2,32
  54:	fea42623          	sw	x10,-20(x8)
  58:	00000013          	addi	x0,x0,0
  5c:	01c12403          	lw	x8,28(x2)
  60:	02010113          	addi	x2,x2,32
  64:	00008067          	jalr	x0,0(x1)

00000068 <main>:
  68:	fe010113          	addi	x2,x2,-32
  6c:	00112e23          	sw	x1,28(x2)
  70:	00812c23          	sw	x8,24(x2)
  74:	02010413          	addi	x8,x2,32
  78:	020007b7          	lui	x15,0x2000
  7c:	fef42423          	sw	x15,-24(x8)
  80:	020007b7          	lui	x15,0x2000
  84:	00478793          	addi	x15,x15,4 # 2000004 <main+0x1ffff9c>
  88:	fef42223          	sw	x15,-28(x8)
  8c:	020007b7          	lui	x15,0x2000
  90:	00878793          	addi	x15,x15,8 # 2000008 <main+0x1ffffa0>
  94:	fef42023          	sw	x15,-32(x8)
  98:	fe442783          	lw	x15,-28(x8)
  9c:	00078023          	sb	x0,0(x15)
  a0:	00100793          	addi	x15,x0,1
  a4:	fef407a3          	sb	x15,-17(x8)
  a8:	0440006f          	jal	x0,ec <main+0x84>
  ac:	fe442783          	lw	x15,-28(x8)
  b0:	0007c783          	lbu	x15,0(x15)
  b4:	0ff7f713          	andi	x14,x15,255
  b8:	fef44783          	lbu	x15,-17(x8)
  bc:	00f707b3          	add	x15,x14,x15
  c0:	0ff7f713          	andi	x14,x15,255
  c4:	fe442783          	lw	x15,-28(x8)
  c8:	00e78023          	sb	x14,0(x15)
  cc:	fe442783          	lw	x15,-28(x8)
  d0:	0007c783          	lbu	x15,0(x15)
  d4:	0ff7f793          	andi	x15,x15,255
  d8:	00078513          	addi	x10,x15,0
  dc:	f41ff0ef          	jal	x1,1c <_put_value>
  e0:	fef44783          	lbu	x15,-17(x8)
  e4:	00178793          	addi	x15,x15,1
  e8:	fef407a3          	sb	x15,-17(x8)
  ec:	fe842783          	lw	x15,-24(x8)
  f0:	0007c783          	lbu	x15,0(x15)
  f4:	0ff7f793          	andi	x15,x15,255
  f8:	fef44703          	lbu	x14,-17(x8)
  fc:	fae7f8e3          	bgeu	x15,x14,ac <main+0x44>
 100:	fe042783          	lw	x15,-32(x8)
 104:	00100713          	addi	x14,x0,1
 108:	00e78023          	sb	x14,0(x15)
 10c:	00000793          	addi	x15,x0,0
 110:	00078513          	addi	x10,x15,0
 114:	01c12083          	lw	x1,28(x2)
 118:	01812403          	lw	x8,24(x2)
 11c:	02010113          	addi	x2,x2,32
 120:	00008067          	jalr	x0,0(x1)
