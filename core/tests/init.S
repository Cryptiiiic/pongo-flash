.text

.pool
.set platform_get_boot_device, 0x10000796c
.set platform_enable_boot_interface, 0x100007a10
.set security_init, 0x100009b14
.set flash_nand_init, 0x100003a84
.set lookup_image_in_bdev, 0x100001a4c
.set flash_nand_register, 0x10000c7fc
.set flash_nand_readRange, 0x100003bb0
.set flash_nand_writeRange, 0x100003e44
.set blockdev_read, 0x10000e9d0

.globl _init
_init:
  sub     sp, sp, #0x30
  stp     x30, x29, [sp, #0x10]
  add     x1,sp,#0x8
  add     x2,sp,#0x4
  mov     x3,sp
  mov     x0,#0x0
  ldr     x29, =platform_get_boot_device
  blr     x29
  cbz     w0,fail
  ldp     w25,w22,[sp, #0x4]
  ldr     w23,[sp]
  mov     w0,#0x1
  mov     x1,x22
  mov     x2,x23
  stp     x1, x2, [sp, #0x20]
  ldr     x29, =platform_enable_boot_interface
  blr     x29
  mov     w28,#0x696c0000
  movk    w28,#0x6c62
  mov     x0,x23
  ldr     x29, =flash_nand_init
  blr     x29
  mov	    x0, #0x7246
  movk	  x0, #0x1, lsl #16
  movk	  x0, #0x1, lsl #32
  mov     w1, w28           /* Doesn't really matter, lookup_image_in_bdev hardcodes to illb anyways */
  ldr     x29, =lookup_image_in_bdev
  blr     x29
  cbnz    x0, exit

fail:
  mov     x0, #0x41

exit:
  mov     x28, x0
  mov     w0,#0x0
  ldp     x1, x2, [sp, #0x20]
  ldr     x29, =platform_enable_boot_interface
  blr     x29
  mov     x0, x28
  ldp     x30, x29, [sp, #0x10]
  add     sp, sp, #0x30
  ret
